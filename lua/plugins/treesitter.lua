return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    local status, ts = pcall(require, "nvim-treesitter.configs")
    if (not status) then return end

    ts.setup({
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      ensure_installed = {
        "c", "cpp",
        "lua",
        "vim", "vimdoc",
        "query",
        "prisma",
        "elixir",
        "heex",
        "html", "css", "javascript", "typescript", "tsx",
        "json",
        "go",
        "rust",
        "graphql"
      },
    })
  end
}
