return {
  {
    "echasnovski/mini.pairs",
    version = "*",
    opts = {
      mappings = {
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\][%s)]" },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\][%s]]" },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\][%s}]" },
        [")"] = { action = "close", pair = "()", neigh_pattern = "[%s(]" },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[%s[]" },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[%s{]" },
        ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\][%s\"]", register = { cr = false } },
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^\\][%s']" },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\][%s`]" },
      },
    },
  },
}
