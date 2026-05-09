-- ============================================================
--  plugins/formatter.lua — conform.nvim
--  Mason cần cài: google-java-format, prettier, stylua
-- ============================================================
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd   = { "ConformInfo" },
    keys  = {
      {
        "<leader>lf",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        -- Java
        java = { "google-java-format" },

        -- Web
        javascript       = { "prettier" },
        typescript       = { "prettier" },
        javascriptreact  = { "prettier" },
        typescriptreact  = { "prettier" },
        html             = { "prettier" },
        css              = { "prettier" },
        scss             = { "prettier" },
        json             = { "prettier" },
        yaml             = { "prettier" },
        markdown         = { "prettier" },

        -- Lua
        lua = { "stylua" },
      },

      -- Format on save
      format_on_save = {
        timeout_ms   = 2000,
        lsp_fallback = true,
      },

      -- Tắt format on save cho các file type không muốn
      format_after_save = function(bufnr)
        local disable_filetypes = { "sql", "proto" }
        if vim.tbl_contains(disable_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        return { lsp_fallback = true }
      end,
    },
  },
}
