-- ~/.config/nvim/lua/plugins/neotree.lua

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      close_if_last_window = true,

      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },

      window = {
        position = "left",
        width = 35,
      },
    },

    keys = {
      {
        "<leader>e",
        "<cmd>Neotree toggle<cr>",
        desc = "File Explorer",
      },

      {
        "<leader>o",
        "<cmd>Neotree focus<cr>",
        desc = "Focus Explorer",
      },
    },
  },
}
