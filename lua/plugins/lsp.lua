-- ============================================================
--  plugins/lsp.lua
--  Mason  →  mason-lspconfig  →  nvim-lspconfig
--  Java (jdtls) được handle riêng trong ftplugin/java.lua
-- ============================================================
return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			-- Tự động cài khi chưa có
			ensure_installed = {
				"jdtls", -- Java  (dùng bởi ftplugin/java.lua)
				"ts_ls", -- TypeScript / JavaScript
				"html",
				"cssls",
				"lua_ls",
				"jsonls",
				"yamlls",
				"dockerls",
				"tailwindcss",
			},
			automatic_installation = true,
		},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- ── Capabilities (thêm cmp) ──────────────────────────
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			-- ── on_attach chung — dùng lại ở ftplugin/java.lua ──
			-- Export ra module để ftplugin/java.lua có thể require
			_G.LspOnAttach = function(_, bufnr)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
				end
				map("gd", vim.lsp.buf.definition, "Go to Definition")
				map("gD", vim.lsp.buf.declaration, "Go to Declaration")
				map("gr", vim.lsp.buf.references, "Go to References")
				map("gI", vim.lsp.buf.implementation, "Go to Implementation")
				map("gy", vim.lsp.buf.type_definition, "Type Definition")
				map("K", vim.lsp.buf.hover, "Hover Docs")
				map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				map("<leader>ds", vim.lsp.buf.document_symbol, "Document Symbols")
				map("<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace Symbols")
				map("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
				map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
				map("<leader>de", vim.diagnostic.open_float, "Diagnostic Float")
				map("<leader>dl", vim.diagnostic.setloclist, "Diagnostic List")
			end

			-- ── Diagnostic signs ────────────────────────────────
			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.diagnostic.config({
				virtual_text = { prefix = "●" },
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded", source = "always" },
			})

			-- ── Servers (tất cả trừ jdtls) ──────────────────────
			local lspconfig = require("lspconfig")

			local servers = {
				ts_ls = {},
				html = { filetypes = { "html", "htmldjango" } },
				cssls = {},
				jsonls = {},
				yamlls = {},
				dockerls = {},
				tailwindcss = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
							diagnostics = { globals = { "vim" } },
						},
					},
				},
			}

			for server, opts in pairs(servers) do
				opts.capabilities = capabilities
				opts.on_attach = _G.LspOnAttach
				lspconfig[server].setup(opts)
			end
		end,
	},
}
