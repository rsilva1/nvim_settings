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
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") });
      -- vim.ui.input({ prompt = "Grep > " }, function(input)
        -- builtin.grep_string({ search = input })
      -- end)
    end)
    require('telescope').load_extension('fzf')
  end,
}
