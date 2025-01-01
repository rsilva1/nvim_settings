return {
  'nvim-telescope/telescope.nvim', tag = '0.1.6',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
  },
  lazy = false,
  config = function()
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>fs', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") });
      -- vim.ui.input({ prompt = "Grep > " }, function(input)
        -- builtin.grep_string({ search = input })
      -- end)
    end)
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    require('telescope').load_extension('fzf')
    local actions = require('telescope.actions')
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-s>"] = actions.cycle_previewers_next,
            ["<C-a>"] = actions.cycle_previewers_prev,
          },
        },
        -- experimenting vertical/center layout to see better filepath and long lines in preview
        layout_strategy = 'vertical',
        layout_config = {
          center = {
            width = 0.9,
            height = function(_, _, max_lines)
              -- return math.min(max_lines * 0.5, 150)
              return 100
            end,
            -- need to tweak things to make previewer work with center
            preview_cutoff = 1
          },
          vertical = {
            width = 0.9,
            height = function(_, _, max_lines)
              -- return math.min(max_lines * 0.5, 150)
              return 100
            end,
            prompt_position = 'bottom',
            preview_cutoff = 0
          }
        }
      }
    })
  end,
}
