vim.g.mapleader = " "

-- General
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Yank & Paste
vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)")
vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)")
vim.keymap.set("n", "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set("n", "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<C-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<C-p>", "<Plug>(YankyCycleBackward)")
