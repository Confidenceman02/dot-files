vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- general keymaps
keymap.set("i", "jj", "<ESC>")
keymap.set("n", "<CR>", ":nohl<CR>")
-- delete single char without copting into register
-- keymap.set("n", "x", '"_x"')

keymap.set("n", "<leader>sv", "<C-w>v") -- split vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- cose current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to new tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab
