return {
  {
    "neovim/nvim-lspconfig",
    -- TLDR LazyFile event roughly equals to BufReadPost, BufWritePost and BufNewFile
    -- https://github.com/LazyVim/LazyVim/discussions/1583#discussioncomment-7187450
    event = "LazyFile",
    cmd = "LspInfo",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = {buffer = event.buf, remap = false }

          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
          vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
          vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>fmt", vim.lsp.buf.format, opts)
        end
      })

      --[[
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(event)
          vim.lsp.buf.format({ buffer = event.buf, async = false })
        end
      })
      --]]

      -- ts organize imports
      --[[
      vim.api.nvim_create_augroup("AutoFormatting", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.tsx?",
        group = "AutoFormatting",
        callback = function()
          -- organize imports
          
          vim.lsp.buf.execute_command({
            command = "_typescript.organizeImports",
            arguments = {vim.api.nvim_buf_get_name(0)},
            title = ""
          })
          vim.lsp.buf.format({ async = false })
        end,
      })
      --]]

      local default_setup = function(server)
        require('lspconfig')[server].setup({
          capabilities = lsp_capabilities,
        })
      end

      local function typescript_organize_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = {vim.api.nvim_buf_get_name(0)},
          title = ""
        }
        vim.lsp.buf.execute_command(params)
      end

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          "eslint",
          "ts_ls",
          "rust_analyzer",
          "dockerls",
          "docker_compose_language_service",
          "tailwindcss",
          "gopls",
          "golangci_lint_ls",
          "ruby_lsp",
          "yamlls",
          "graphql"
        },
        handlers = {
          default_setup,
          eslint = function()
            local util = require('lspconfig.util')
            require('lspconfig').eslint.setup({
              root_dir = util.root_pattern('.git')(fname),
            })
          end,
          ts_ls = function()
            local util = require('lspconfig.util')

            require('lspconfig').ts_ls.setup({
              root_dir = util.root_pattern('.git')(fname),
              capabilities = lsp_capabilities,
              init_options = { 
                preferences = { 
                  quotePreference = 'double',
                  -- absolute breaks nest+jest (https://stackoverflow.com/questions/56703570/unable-to-run-tests-because-nest-cannot-find-a-module)
                  importModuleSpecifier = "relative",
                  importModuleSpecifierPreference = "relative",
                  importModuleSpecifierEnding = "auto",
                },
                host_info = "nvim",
              },
              settings = {
                formatOptions = {
                  enabled = true,
                },
              },
              commands = {
                OrganizeImports = {
                  typescript_organize_imports,
                  description = "Organize Imports"
                }
              },
            })
          end,
          -- I'm still not 100% sure if this is solving my old issue of rust_analyzer not running on unlinked files (e.g. test scripts)
          rust_analyzer = function()
            require('lspconfig').rust_analyzer.setup({
              cargo = {
                features = "all"
              },
              completion = {
                autoimport = {
                  enable = "true"
                }
              }
            })
          end,
          yamlls = function()
            require('lspconfig').yamlls.setup({
              settings = {
                yaml = {
                  schemas = {
                    kubernetes = "k8s-*.yaml",
                    ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                    ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                    ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
                    ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                    ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                    ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                    ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
                    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.{yml,yaml}",
                  },
                },
              },
            })
          end
        },
      })

      -- borders
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        {border = 'rounded'}
      )

      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {border = 'rounded'}
      )
      vim.diagnostic.config({
        float = {
          border = 'rounded',
        },
      })
    end
  },
}
