local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })

map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })

map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous tab" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next tab" })
map("n", "<leader>c", "<cmd>bdelete<cr>", { desc = "Close buffer" })

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
