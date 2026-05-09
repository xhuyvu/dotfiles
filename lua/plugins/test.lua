-- ============================================================
--  plugins/test.lua — neotest + neotest-java
-- ============================================================
return {
  {
    "nvim-neotest/neotest",
    event        = { "BufReadPre *.java", "BufReadPre *_test.ts", "BufReadPre *.spec.ts" },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Adapters
      "rcasia/neotest-java",          -- JUnit 4 / 5
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-java")({
            ignore_wrapper = false,   -- dùng ./mvnw hoặc ./gradlew nếu có
          }),
        },
        summary = {
          open = "botright vsplit | vertical resize 50",
        },
        output = {
          open_on_run = true,
        },
        icons = {
          failed       = " ",
          passed       = " ",
          running      = "󰑮 ",
          skipped      = " ",
          unknown      = " ",
          watching     = "󰈈 ",
        },
      })

      local nt  = require("neotest")
      local map = vim.keymap.set

      map("n", "<leader>tn", function() nt.run.run() end,
        { desc = "Test: Run Nearest" })
      map("n", "<leader>tf", function() nt.run.run(vim.fn.expand("%")) end,
        { desc = "Test: Run File" })
      map("n", "<leader>ta", function() nt.run.run(vim.fn.getcwd()) end,
        { desc = "Test: Run All" })
      map("n", "<leader>ts", function() nt.summary.toggle() end,
        { desc = "Test: Summary" })
      map("n", "<leader>to", function() nt.output.open({ enter = true }) end,
        { desc = "Test: Output" })
      map("n", "<leader>tO", function() nt.output_panel.toggle() end,
        { desc = "Test: Output Panel" })
      map("n", "<leader>tS", function() nt.run.stop() end,
        { desc = "Test: Stop" })
    end,
  },
}
