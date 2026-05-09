-- ============================================================
--  core/keymap.lua — global keymaps
--  LSP-specific keymaps → lua/plugins/lsp.lua (on_attach)
--  Java-specific keymaps → ftplugin/java.lua
-- ============================================================
local map = vim.keymap.set

vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- ── General ──────────────────────────────────────────────────
map("n", "<leader>w", "<cmd>w<CR>",  { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>",  { desc = "Quit" })
map("n", "<leader>x", "<cmd>x<CR>",  { desc = "Save & Quit" })

-- Clear highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Better up/down on wrapped lines
map({ "n", "x" }, "j", "gj")
map({ "n", "x" }, "k", "gk")

-- ── Window navigation ─────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })

-- ── Resize windows ────────────────────────────────────────────
map("n", "<C-Up>",    "<cmd>resize +2<CR>")
map("n", "<C-Down>",  "<cmd>resize -2<CR>")
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- ── Buffers ───────────────────────────────────────────────────
map("n", "<S-l>", "<cmd>bnext<CR>",     { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- ── Move lines ───────────────────────────────────────────────
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- ── Indenting ─────────────────────────────────────────────────
map("v", "<", "<gv")
map("v", ">", ">gv")

-- ── Terminal ─────────────────────────────────────────────────
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>tt", "<cmd>terminal<CR>", { desc = "Open terminal" })
