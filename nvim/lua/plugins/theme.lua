return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    opts = { contrast = "hard" },
    config = function()
        vim.cmd.colorscheme("gruvbox")
    end,
  },
}
