vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false 
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 200

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

-- Syntax of Jenkinsfile
vim.api.nvim_create_autocmd("BufRead", {
  pattern = {
    "*Jenkinsfile",
    "Jenkinsfile*",
    "*JenkinsFile",
    "JenkinsFile*",
  },
  callback = function(event)
    local opts = {buf = vim.api.nvim_get_current_buf() }
    vim.api.nvim_set_option_value("syntax", "groovy", opts)
  end,
})

-- Syntax of curl files
vim.api.nvim_create_autocmd("BufRead", {
  pattern = {
    "*.curl",
  },
  callback = function(event)
    local opts = {buf = vim.api.nvim_get_current_buf() }
    vim.api.nvim_set_option_value("syntax", "zsh", opts)
  end,
})

-- Syntax of mustache files
vim.api.nvim_create_autocmd("BufRead", {
  pattern = {
    "*.html.mustache",
  },
  callback = function(event)
    local opts = {buf = vim.api.nvim_get_current_buf() }
    vim.api.nvim_set_option_value("filetype", "html", opts)
    vim.api.nvim_set_option_value("syntax", "html", opts)
  end,
})
