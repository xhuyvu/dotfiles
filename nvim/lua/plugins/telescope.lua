return {
  {
    "nvim-telescope/telescope.nvim",

    opts = {
      defaults = {
        layout_strategy = "horizontal",

        layout_config = {
          horizontal = {
            preview_width = 0.55,
          },
        },

        sorting_strategy = "ascending",

        prompt_prefix = "❯ ",

        selection_caret = "➜ ",

        path_display = {
          "truncate",
        },
      },
    },

    keys = {
      {
        "<leader>ff",
        "<cmd>Telescope find_files<cr>",
        desc = "Find Files",
      },

      {
        "<leader>fg",
        "<cmd>Telescope live_grep<cr>",
        desc = "Live Grep",
      },

      {
        "<leader>fb",
        "<cmd>Telescope buffers<cr>",
        desc = "Buffers",
      },

      {
        "<leader>fh",
        "<cmd>Telescope help_tags<cr>",
        desc = "Help",
      },

      {
        "<leader>fr",
        "<cmd>Telescope oldfiles<cr>",
        desc = "Recent Files",
      },
    },
  },
}
