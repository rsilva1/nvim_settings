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
      {"hrsh7th/cmp-nvim-lsp"},
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
          vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
          vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
          vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
          vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
          vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
          vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
          vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
          vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
          vim.keymap.set("n", "<leader>fmt", function() vim.lsp.buf.format() end, opts)
        end
      })

      vim.api.nvim_create_augroup("AutoFormatting", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.ts",
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
          "tsserver",
          "rust_analyzer",
          "dockerls",
          "docker_compose_language_service",
          "tailwindcss",
          "gopls",
          "golangci_lint_ls",
        },
        handlers = {
          default_setup,
          tsserver = function()
            require('lspconfig').tsserver.setup({
              capabilities = lsp_capabilities,
              init_options = { 
                preferences = { 
                  importModuleSpecifierPreference = "shortest", 
                  importModuleSpecifierEnding = "minimal", 
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
        },
      })
    end
  },
}
