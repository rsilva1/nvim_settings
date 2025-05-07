return {
  'windwp/nvim-ts-autotag',
  name = 'ts-autotag',
  lazy = false,
  config = function()
    local status, autotag = pcall(require, 'nvim-ts-autotag')
    if (not status) then return end

    autotag.setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    })
  end
}
