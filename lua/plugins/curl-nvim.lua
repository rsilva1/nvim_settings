return {
  "oysandvik94/curl.nvim",
  cmd = { "CurlOpen" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local curl = require("curl")
    curl.setup({
      -- Table of strings to specify default headers to be included in each request, i.e. "-i"
      default_flags = {},
      -- Specify an alternative curl binary that will be used to run curl commands
      -- String of either full path, or binary in path
      curl_binary = nil,
      -- Specify how to open curl
      -- use "tab" to open in separate tab
      -- use "split" to open in horizontal split
      -- use "vsplit" to open in vertical split
      open_with = "tab",
      mappings = {
        execute_curl = "<CR>"
      }
    })
  end,
}
