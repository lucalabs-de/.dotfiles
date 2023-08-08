vim.g.mapleader = " "

-- General
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-g><C-p>", ":lua SetWorkingDir()<CR>")

-- Yank & Paste
vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)")
vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)")
vim.keymap.set("n", "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set("n", "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<C-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<C-p>", "<Plug>(YankyCycleBackward)")

-- Convenient jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Convenient editing
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
