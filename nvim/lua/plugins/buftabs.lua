return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "buffers",
        show_close_icon = false,
        show_buffer_close_icons = false,
        separator_style = "thin",
        diagnostics = false,
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      local u = require("bufferline.utils")
      local fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
      local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg

      vim.api.nvim_set_hl(0, "BufferLineFill", { fg = fg, bg = bg })
      vim.api.nvim_set_hl(0, "BufferLineBackground", { fg = fg, bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineBuffer", { fg = fg, bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { fg = fg, bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineTab", { fg = fg, bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineTabSeparator", { fg = fg, bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = fg, bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineDuplicateSelected", { bg = "NONE" })
    end,
  },
}
