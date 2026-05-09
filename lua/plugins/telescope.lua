-- ============================================================
--  plugins/telescope.lua
-- ============================================================
return {
  {
    "nvim-telescope/telescope.nvim",
    branch       = "0.1.x",
    cmd          = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond  = function() return vim.fn.executable("make") == 1 end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    keys = {
      -- Files
      { "<leader>ff", "<cmd>Telescope find_files<CR>",              desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>",               desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>",                 desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>",               desc = "Help Tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>",                desc = "Recent Files" },
      { "<leader>fw", "<cmd>Telescope grep_string<CR>",             desc = "Grep Word" },
      -- Git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>",             desc = "Git Commits" },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>",            desc = "Git Branches" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>",              desc = "Git Status" },
      -- LSP (dùng khi không trong Java buffer)
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>",             desc = "Diagnostics" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>",    desc = "Document Symbols" },
    },
    config = function()
      local telescope = require("telescope")
      local actions   = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix   = " ",
          selection_caret = " ",
          path_display    = { "truncate" },
          sorting_strategy = "ascending",
          layout_config   = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical   = { mirror = false },
            width      = 0.87,
            height     = 0.80,
          },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Esc>"] = actions.close,
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end,
  },
}
