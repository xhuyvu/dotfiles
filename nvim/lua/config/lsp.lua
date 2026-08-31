local map = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    local buf = args.buf

    map("n", "gd", function() vim.lsp.buf.definition() end, { buffer = buf, desc = "Go to definition" })
    map("n", "K", function() vim.lsp.buf.hover() end, { buffer = buf, desc = "Hover" })
    map("n", "gr", function() vim.lsp.buf.references() end, { buffer = buf, desc = "References" })
    map("n", "gD", function() vim.lsp.buf.declaration() end, { buffer = buf, desc = "Go to declaration" })
    map("n", "gi", function() vim.lsp.buf.implementation() end, { buffer = buf, desc = "Go to implementation" })
    map("n", "<leader>rn", function() vim.lsp.buf.rename() end, { buffer = buf, desc = "Rename symbol" })
    map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { buffer = buf, desc = "Code action" })
    map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { buffer = buf, desc = "Format buffer" })
    map("n", "g[", function() vim.diagnostic.goto_prev() end, { buffer = buf, desc = "Previous diagnostic" })
    map("n", "g]", function() vim.diagnostic.goto_next() end, { buffer = buf, desc = "Next diagnostic" })

    if client:supports_method("textDocument/inlayHint") then
      map("n", "<leader>th", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(buf)) end,
        { buffer = buf, desc = "Toggle inlay hints" })
    end
  end,
})
