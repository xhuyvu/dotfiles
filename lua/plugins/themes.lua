return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,

		opts = {
			transparent_mode = true,
		},

		config = function(_, opts)
			require("gruvbox").setup(opts)

			vim.cmd.colorscheme("gruvbox")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		opts = {
			options = {
				theme = "gruvbox",
			},
		},
	},
}
