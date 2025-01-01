return {
  'windwp/nvim-ts-autotag',
  name = 'ts-autotag',
  lazy = false,
  config = function()
    local status, autotag = pcall(require, 'nvim-ts-autotag')
    if (not status) then return end

    autotag.setup({})
  end
}
