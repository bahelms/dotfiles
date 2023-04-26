local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<leader>d', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '<leader>cr', function() vim.lsp.buf.rename() end, opts)
  -- vim.keymap.set('n', '<leader>cd', function() vim.diagnostic.open_float() end, opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-d>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end)

lsp.ensure_installed({
  'tsserver', 'lua_ls', 'elixirls', 'gopls', 'clangd'
})

-- LSP servers
require('lspconfig').elixirls.setup {
  -- you have to manually specify the entrypoint cmd for elixir-ls
  cmd = { os.getenv('HOME') .. '/.elixir-ls/language_server.sh' },
  -- on_attach = on_attach,
  -- capabilities = capabilities,
}

lsp.setup()

local cmp = require('cmp')

require('luasnip.loaders.from_vscode').lazy_load() -- friendly snippets

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-e>'] = cmp.mapping.abort(),
  },
  window = {
    completion = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'luasnip' },
  })
})

-- format on save
vim.cmd([[
autocmd BufWritePre * lua vim.lsp.buf.format()
]])

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
vim.lsp.handlers["textDocument/signature_help"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})
