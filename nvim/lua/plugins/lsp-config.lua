return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ruff",
      },
      automatic_installation = true,
      handlers = {
        function(server_name)
          local capabilities = require("blink.cmp").get_lsp_capabilities()
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["lua_ls"] = function()
          local capabilities = require("blink.cmp").get_lsp_capabilities()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
              },
            },
          })
        end,
      },
    },
  },
}
