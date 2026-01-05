return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- autocompletion
    'hrsh7th/nvim-cmp', -- Required
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp', -- Required

    -- snippets
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    'hrsh7th/cmp-cmdline',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('my.lsp', {}),
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local buf    = args.buf
        local map    = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = buf }) end

        map('n', 'K', vim.lsp.buf.hover)
        map('n', 'gd', vim.lsp.buf.definition)
        map('n', 'gD', vim.lsp.buf.declaration)
        map('n', 'gi', vim.lsp.buf.implementation)
        map('n', 'go', vim.lsp.buf.type_definition)
        map('n', 'gr', vim.lsp.buf.references)
        map('n', 'gs', vim.lsp.buf.signature_help)
        map('n', 'gl', vim.diagnostic.open_float)
        map('n', '<F2>', vim.lsp.buf.rename)
        map({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end)
        map('n', '<F4>', vim.lsp.buf.code_action)

        local excluded_filetypes = { php = true, c = true, cpp = true }
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting')
            and not excluded_filetypes[vim.bo[buf].filetype]
        then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('my.lsp.format', { clear = false }),
            buffer = buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
            end,
          })
        end
      end,
    })
    local caps = require("cmp_nvim_lsp").default_capabilities()
    require('mason').setup({})
    require('mason-lspconfig').setup({
      -- Replace the language servers listed here
      -- with the ones you want to install
      ensure_installed = { 'lua_ls', 'clangd', 'ts_ls' },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({})
        end,

        clangd = function()
          require('lspconfig').clangd.setup {
            init_options = {
              fallbackFlags = { '-std=c++20' }
            }
          }
        end,
      },
    })

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
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
      })
    })

    -- give popups borders
    local orig = vim.lsp.util.open_floating_preview
    ---@diagnostic disable-next-line: duplicate-set-field
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts            = opts or {}
      opts.border     = opts.border or 'rounded'
      opts.max_width  = opts.max_width or 80
      opts.max_height = opts.max_height or 24
      opts.wrap       = opts.wrap ~= false
      return orig(contents, syntax, opts, ...)
    end
  end,
}
