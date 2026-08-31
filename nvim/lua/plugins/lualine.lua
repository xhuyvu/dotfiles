return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      options = {
        theme = "gruvbox",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        -- arrows between mode and the rest
        section_separators = { left = "", right = "▸" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
}
