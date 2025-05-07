return {
  'windwp/nvim-autopairs',
  name = 'autopairs',
  event = 'InsertEnter',
  config = function()
    local status, autopairs = pcall(require, "nvim-autopairs")
    if (not status) then return end

    autopairs.setup({
      disable_filetype = { "TelescopePrompt" , "vim", "lua" },
    })
  end
}
