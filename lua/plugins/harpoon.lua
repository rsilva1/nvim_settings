return {
  'theprimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local mark = require('harpoon.mark')
    local ui = require('harpoon.ui')

    require('harpoon').setup({
      menu = {
        -- default width is 60
        width = 120,
        -- width = vim.api.nvim_win_get_width(0) - 8, -- too wide to my taste
      },
      mark_branch = true, -- https://github.com/ThePrimeagen/harpoon/pull/98
    })

    vim.keymap.set("n", "<leader>a", mark.add_file)
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

    vim.keymap.set("n", "<leader>ha", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<leader>hs", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<leader>hd", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<leader>hf", function() ui.nav_file(4) end)
  end,
}
