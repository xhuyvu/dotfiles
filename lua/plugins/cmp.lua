return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help", -- signature khi gõ tham số
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind.nvim", -- icon đẹp như IntelliJ
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				-- ── Snippet ────────────────────────────────────────
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				-- ── Completion behavior ────────────────────────────
				completion = {
					completeopt = "menu,menuone,noinsert", -- auto-highlight item đầu tiên
					keyword_length = 1, -- gợi ý từ ký tự đầu tiên
				},

				-- ── Preselect như IntelliJ ─────────────────────────
				preselect = cmp.PreselectMode.Item,

				-- ── Window ────────────────────────────────────────
				window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
						border = "rounded",
					},
					-- Doc popup bên phải như IntelliJ
					documentation = {
						border = "rounded",
						max_width = 60,
						max_height = 20,
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu",
					},
				},

				-- ── Keymaps ───────────────────────────────────────
				mapping = cmp.mapping.preset.insert({
					-- Điều hướng như IntelliJ (arrow keys / C-n C-p)
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

					-- Scroll doc popup
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- C-Space force mở như IntelliJ Ctrl+Space
					["<C-Space>"] = cmp.mapping.complete(),

					-- Esc đóng menu, KHÔNG insert gì
					["<C-e>"] = cmp.mapping.abort(),
					["<Esc>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.abort()
						else
							fallback()
						end
					end, { "i" }),

					-- Enter confirm như IntelliJ
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() and cmp.get_active_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						else
							fallback() -- Enter bình thường nếu không có item được chọn
						end
					end, { "i", "s" }),

					-- Tab: expand snippet hoặc jump placeholder
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				-- ── Formatting — giống IntelliJ ───────────────────
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						show_labelDetails = true, -- hiện detail như IntelliJ

						-- Custom label cho Spring annotations
						before = function(entry, vim_item)
							-- Đánh dấu source
							vim_item.menu = ({
								nvim_lsp = "[LSP]",
								nvim_lsp_signature_help = "[Sig]",
								luasnip = "[Snip]",
								buffer = "[Buf]",
								path = "[Path]",
							})[entry.source.name] or ""

							-- Highlight annotation (@Bean, @Service...) khác màu
							if vim_item.abbr:sub(1, 1) == "@" then
								vim_item.kind = "  Annotation"
							end

							return vim_item
						end,
					}),
				},

				-- ── Sources — thứ tự ưu tiên như IntelliJ ─────────
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "nvim_lsp_signature_help", priority = 950 }, -- tham số hàm
					{ name = "luasnip", priority = 750 },
					{
						name = "buffer",
						priority = 500,
						option = {
							-- Gợi ý từ tất cả buffer đang mở (như IntelliJ project-wide)
							get_bufnrs = function()
								return vim.api.nvim_list_bufs()
							end,
						},
					},
					{ name = "path", priority = 250 },
				}),

				-- Không gợi ý trong comment
				enabled = function()
					local ctx = require("cmp.config.context")
					if vim.api.nvim_get_mode().mode == "c" then
						return true
					end
					return not ctx.in_treesitter_capture("comment") and not ctx.in_syntax_group("Comment")
				end,

				-- ── Sorting — ưu tiên item khớp đầu chuỗi như IntelliJ
				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
			})

			-- ── Cmdline ───────────────────────────────────────────
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})
		end,
	},
}
