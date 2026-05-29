

-- Line number
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = false

-- Basic editor
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- UI
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.scrolloff = 8

-- Clipboard: copy ra ngoài hệ thống
vim.opt.clipboard = "unnamedplus"

-- Colorscheme có sẵn của Neovim
vim.cmd("syntax enable")
vim.cmd("colorscheme habamax")
