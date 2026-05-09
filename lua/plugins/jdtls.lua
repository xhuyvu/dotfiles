return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java", -- lazy load, chỉ nạp khi mở file .java
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		-- config để trống — ftplugin/java.lua lo phần này
	},
}
