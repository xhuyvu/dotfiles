return {

  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-emoji",
  },

  opts = function(_, opts)
    local cmp = require("cmp")

    table.insert(opts.sources, {
      name = "emoji",
    })

    opts.window = {
      completion = cmp.config.window.bordered(),
      documentation = false,
    }

    return opts
  end,
}
