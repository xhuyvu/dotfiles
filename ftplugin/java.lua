-- ============================================================
--  ftplugin/java.lua
-- ============================================================
local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
	return
end

-- ── Paths ────────────────────────────────────────────────────
local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
local jdtls_path = mason_path .. "/jdtls"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local os_config = "config_linux"
if vim.fn.has("mac") == 1 then
	os_config = "config_mac"
elseif vim.fn.has("win32") == 1 then
	os_config = "config_win"
end

-- ── Bundles ───────────────────────────────────────────────────
local bundles = {}
local debug_jar =
	vim.fn.glob(mason_path .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
if debug_jar ~= "" then
	vim.list_extend(bundles, { debug_jar })
end
vim.list_extend(
	bundles,
	vim.split(vim.fn.glob(mason_path .. "/java-test/extension/server/*.jar", true), "\n", { trimempty = true })
)

-- ── Capabilities ─────────────────────────────────────────────
local capabilities = vim.tbl_deep_extend(
	"force",
	vim.lsp.protocol.make_client_capabilities(),
	require("cmp_nvim_lsp").default_capabilities()
)

-- Bật snippet support — bắt buộc để annotation completion hoạt động
capabilities.textDocument.completion.completionItem = {
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = { "documentation", "detail", "additionalTextEdits" },
	},
}

-- ── on_attach ─────────────────────────────────────────────────
local function on_attach(client, bufnr)
	if _G.LspOnAttach then
		_G.LspOnAttach(client, bufnr)
	end

	if #bundles > 0 then
		jdtls.setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end

	local map = function(k, f, desc)
		vim.keymap.set("n", k, f, { buffer = bufnr, desc = "Java: " .. desc })
	end
	local mapv = function(k, f, desc)
		vim.keymap.set("v", k, f, { buffer = bufnr, desc = "Java: " .. desc })
	end

	map("<leader>Jo", jdtls.organize_imports, "Organize Imports")
	map("<leader>Jev", jdtls.extract_variable, "Extract Variable")
	map("<leader>Jec", jdtls.extract_constant, "Extract Constant")
	map("<leader>Jem", jdtls.extract_method, "Extract Method")
	mapv("<leader>Jem", function()
		jdtls.extract_method(true)
	end, "Extract Method (visual)")
	map("<leader>Jt", jdtls.test_nearest_method, "Test Nearest Method")
	map("<leader>JT", jdtls.test_class, "Test Class")
	map("<leader>Ju", "<cmd>JdtUpdateConfig<CR>", "Update Config")
end

-- ── Config ────────────────────────────────────────────────────
local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.level=ALL",
		"-Xmx4g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		jdtls_path .. "/" .. os_config,
		"-data",
		workspace,
	},

	root_dir = require("jdtls.setup").find_root({
		".git",
		"mvnw",
		"gradlew",
		"pom.xml",
		"build.gradle",
		"build.gradle.kts",
	}),

	capabilities = capabilities,
	on_attach = on_attach,

	settings = {
		java = {
			eclipse = { downloadSources = true },
			maven = { downloadSources = true },
			references = { includeDecompiledSources = true },
			inlayHints = { parameterNames = { enabled = "all" } },
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },

			completion = {
				enabled = true,
				guessMethodArguments = true, -- tự điền tham số như IntelliJ
				postfixCompletionSupport = true,
				importOrder = { "java", "javax", "org.springframework", "com", "org" },
				favoriteStaticMembers = {
					"org.junit.Assert.*",
					"org.junit.jupiter.api.Assertions.*",
					"org.mockito.Mockito.*",
					"org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
					"org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
				},
				-- Ẩn các annotation nội bộ rác, chỉ giữ annotation hữu ích
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"sun.*",
				},
			},

			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},

			codeGeneration = {
				toString = { template = "${object.className}{${member.name()}=${member.value}, }" },
				hashCodeEquals = { useJava7Objects = true, useInstanceof = true },
				useBlocks = true,
			},
		},
	},

	init_options = {
		bundles = bundles,
		extendedClientCapabilities = vim.tbl_deep_extend("force", jdtls.extendedClientCapabilities, {
			-- Bật annotation completion
			classFileContentsSupport = true,
			generateToStringPromptSupport = true,
			hashCodeEqualsPromptSupport = true,
			advancedOrganizeImportsSupport = true,
			generateConstructorsPromptSupport = true,
			generateDelegateMethodsPromptSupport = true,
			moveRefactoringSupport = true,
			inferSelectionSupport = { "extractMethod", "extractVariable", "extractConstant" },
		}),
	},
}

jdtls.start_or_attach(config)

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
