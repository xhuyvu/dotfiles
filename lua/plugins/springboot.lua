return {
	{
		"elmcgill/springboot-nvim",
		ft = "java",
		dependencies = {
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-jdtls",
		},
		config = function()
			local springboot = require("springboot-nvim")
			springboot.setup({})

			local map = function(k, f, desc)
				vim.keymap.set("n", k, f, { buffer = true, desc = "Spring: " .. desc })
			end

			-- Generate
			map("<leader>Jgc", springboot.generate_class, "New Class")
			map("<leader>Jgi", springboot.generate_interface, "New Interface")
			map("<leader>Jge", springboot.generate_enum, "New Enum")

			-- Run Spring Boot trong terminal split dưới
			map("<leader>Jr", function()
				-- Tìm mvnw trong root, fallback về mvn
				local root = vim.fn.findfile("mvnw", vim.fn.getcwd() .. ";")
				local cmd
				if root ~= "" then
					cmd = "./mvnw spring-boot:run"
				else
					cmd = "mvn spring-boot:run"
				end

				-- Mở terminal split dưới
				vim.cmd("botright 15split")
				vim.cmd("terminal " .. cmd)
				vim.cmd("startinsert")
			end, "Run App (terminal split)")

			-- Stop: chỉ cần đóng terminal buffer
			map("<leader>Jk", function()
				-- Tìm buffer terminal đang chạy spring
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					local name = vim.api.nvim_buf_get_name(buf)
					if name:match("term://") and name:match("spring") then
						vim.api.nvim_buf_delete(buf, { force = true })
						return
					end
				end
				-- Nếu không tìm được thì kill process port 8080
				vim.fn.jobstart("fuser -k 8080/tcp", { detach = true })
				print("Killed process on :8080")
			end, "Kill App")
		end,
	},
}
--[[ return {

	{
		"elmcgill/springboot-nvim",
		ft = "java",
		dependencies = {
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-jdtls",
		},
		config = function()
			local springboot = require("springboot-nvim")

			springboot.setup({
				-- Tự detect mvnw / gradlew trong project root
				-- Không cần config thêm nếu dùng wrapper
			})

			local map = function(k, f, desc)
				vim.keymap.set("n", k, f, { buffer = true, desc = "Spring: " .. desc })
			end

			-- Run / Stop
			map("<leader>Jr", springboot.boot_run, "Run App")
			-- Generate
			map("<leader>Jgc", springboot.generate_class, "New Class")
			map("<leader>Jgi", springboot.generate_interface, "New Interface")
			map("<leader>Jge", springboot.generate_enum, "New Enum")
		end,
	},
} ]]
