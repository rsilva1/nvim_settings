vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv'")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv'")
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

-- keep cursor in place when J (put line below after end of current line)
vim.keymap.set("n", "J", "mzJ`z")

-- zz centers cursor vertically
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- zv - open fold
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- do not overwite copy register
vim.keymap.set("x", "<leader>p", "\"_dP")

-- yank also to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- <leader>s now enables to replace the current hovered word across the whole file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>is", [[:.s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- creating new window moves to them
vim.keymap.set("n", "<C-w>v", "<C-w>v<C-w>w");
vim.keymap.set("n", "<C-w>v", "<C-w>v<C-w>w");
vim.keymap.set("n", "<C-w>s", "<C-w>s<C-w>w");
vim.keymap.set("n", "<C-w>S", "<C-w>S<C-w>w");

-- move between windows without ctrl w
vim.keymap.set("n", "<C-h>", "<C-w><C-h>");
vim.keymap.set("v", "<C-h>", "<C-w><C-h>");
vim.keymap.set("n", "<C-l>", "<C-w><C-l>");
vim.keymap.set("v", "<C-l>", "<C-w><C-l>");

vim.keymap.set("n", "<C-j>", "<C-w><C-j>");
vim.keymap.set("v", "<C-j>", "<C-w><C-j>");
vim.keymap.set("n", "<C-k>", "<C-w><C-k>");
vim.keymap.set("v", "<C-k>", "<C-w><C-k>");

