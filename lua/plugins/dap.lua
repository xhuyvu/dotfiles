-- ============================================================
--  plugins/dap.lua — Debug Adapter Protocol
--  Java debug được wire vào jdtls trong ftplugin/java.lua
-- ============================================================
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
      },
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<F5>",         desc = "DAP: Continue" },
      { "<F10>",        desc = "DAP: Step Over" },
      { "<F11>",        desc = "DAP: Step Into" },
      { "<F12>",        desc = "DAP: Step Out" },
      { "<leader>db",   desc = "DAP: Toggle Breakpoint" },
      { "<leader>dB",   desc = "DAP: Conditional Breakpoint" },
      { "<leader>du",   desc = "DAP: Toggle UI" },
      { "<leader>dr",   desc = "DAP: REPL" },
      { "<leader>dl",   desc = "DAP: Run Last" },
    },
    config = function()
      local dap    = require("dap")
      local dapui  = require("dapui")

      -- ── DAP UI setup ──────────────────────────────────────
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        layouts = {
          {
            elements = {
              { id = "scopes",      size = 0.40 },
              { id = "breakpoints", size = 0.20 },
              { id = "stacks",      size = 0.20 },
              { id = "watches",     size = 0.20 },
            },
            position = "left",
            size     = 40,
          },
          {
            elements = {
              { id = "repl",    size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size     = 10,
          },
        },
      })

      -- Virtual text cho debug
      require("nvim-dap-virtual-text").setup({
        commented = true,
      })

      -- Tự mở/đóng DAP UI
      dap.listeners.after.event_initialized["dapui_config"]  = dapui.open
      dap.listeners.before.event_terminated["dapui_config"]  = dapui.close
      dap.listeners.before.event_exited["dapui_config"]      = dapui.close

      -- ── Keymaps ───────────────────────────────────────────
      local map = vim.keymap.set
      map("n", "<F5>",       dap.continue,          { desc = "DAP: Continue" })
      map("n", "<F10>",      dap.step_over,         { desc = "DAP: Step Over" })
      map("n", "<F11>",      dap.step_into,         { desc = "DAP: Step Into" })
      map("n", "<F12>",      dap.step_out,          { desc = "DAP: Step Out" })
      map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
      map("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP: Conditional Breakpoint" })
      map("n", "<leader>du", dapui.toggle,          { desc = "DAP: Toggle UI" })
      map("n", "<leader>dr", dap.repl.open,         { desc = "DAP: REPL" })
      map("n", "<leader>dl", dap.run_last,          { desc = "DAP: Run Last" })
      map("n", "<leader>dx", dap.terminate,         { desc = "DAP: Terminate" })
    end,
  },
}
