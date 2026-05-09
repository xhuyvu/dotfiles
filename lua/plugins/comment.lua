-- ============================================================
--  plugins/comment.lua
-- ============================================================
return {
  {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    opts  = {
      -- gcc → toggle line comment
      -- gbc → toggle block comment
      -- gc  (visual) → toggle selection
      padding   = true,
      sticky    = true,
      toggler   = { line = "gcc", block = "gbc" },
      opleader  = { line = "gc",  block = "gb" },
      mappings  = { basic = true, extra = true },
    },
  },
}
