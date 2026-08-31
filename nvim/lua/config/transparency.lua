local set_hl = function(name, opts)
    opts.bg = "NONE"
    opts.ctermbg = "NONE"
    vim.api.nvim_set_hl(0, name, opts)
end

local apply_transparency = function()
    set_hl("Normal", {})
    set_hl("NormalFloat", {})
    set_hl("SignColumn", {})
    set_hl("LineNr", {})
    set_hl("CursorLine", {})
    set_hl("CursorLineNr", {})
    set_hl("EndOfBuffer", {})
    set_hl("WinSeparator", {})
    set_hl("StatusLine", {})
    set_hl("StatusLineNC", {})
    set_hl("TabLine", {})
    set_hl("TabLineFill", {})

    set_hl("Pmenu", {})
    set_hl("PmenuSel", {})
    set_hl("PmenuSbar", {})
    set_hl("PmenuThumb", {})

    set_hl("FloatBorder", {})
    set_hl("TelescopeNormal", {})
    set_hl("TelescopeBorder", {})

    set_hl("NeoTreeNormal", {})
    set_hl("NeoTreeNormalNC", {})
    set_hl("NeoTreeFloatNormal", {})
    set_hl("LspInlayHint", {})
end

apply_transparency()

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = apply_transparency,
})
