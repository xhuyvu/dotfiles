return {
	{
		"stevearc/oil.nvim",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			require("oil").setup({
				default_file_explorer = false,

				columns = {
					"icon",
				},

				view_options = {
					show_hidden = true,
				},

				float = {
					padding = 4,
					max_width = 100,
					max_height = 35,
					border = "rounded",
				},

				keymaps = {
					["<Esc>"] = "actions.close",
					["q"] = "actions.close",
				},
			})

			-- transparency
			vim.cmd([[
        highlight NormalFloat guibg=NONE
        highlight FloatBorder guibg=NONE
      ]])

			-- open floating oil
			vim.keymap.set("n", "<leader>ee", function()
				require("oil").open_float()
			end, { desc = "Open Oil" })
		end,
	},
}
