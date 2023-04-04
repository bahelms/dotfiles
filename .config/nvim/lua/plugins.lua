local execute = vim.api.nvim_command
local fn = vim.fn
local fmt = string.format
local pack_path = fn.stdpath("data") .. "/site/pack"
-- ensure a given plugin from github.com/<user>/<repo> is cloned in the pack/packer/start directory
local function ensure(user, repo)
  local install_path = fmt("%s/packer/start/%s", pack_path, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end
ensure("wbthomason", "packer.nvim") -- ensure the plugin manager is installed

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer itself

  use 'tpope/vim-commentary'   -- comments
  use 'tpope/vim-fugitive'     -- Git commands
  use 'tpope/vim-projectionist'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-vinegar' -- file tree
  -- use 'sheerun/vim-polyglot'
  -- use 'easymotion/vim-easymotion'
  use 'ggandor/leap.nvim' -- easymotion replacement
  use 'jiangmiao/auto-pairs'
  use 'wesQ3/vim-windowswap'
  use 'lewis6991/gitsigns.nvim' -- show git changes in gutter, manage hunks
  use({
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
  })
  use { -- fuzzy finder
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- colorschemes
  use 'nvim-telescope/telescope-file-browser.nvim'
  use { 'dracula/vim', as = 'dracula' }
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "bluz71/vim-moonfly-colors", as = "moonfly" }

  -- manages LSP servers
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  -- lsp - language server protocol
  use { 'neovim/nvim-lspconfig' }
  use { 'hrsh7th/nvim-cmp' } -- cmp framework for auto-completion support

  -- install different completion source
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }

  -- you need a snippet engine for snippet support
  -- here I'm using vsnip which can load snippets in vscode format
  use { 'hrsh7th/vim-vsnip' }
  use { 'hrsh7th/cmp-vsnip' }
  use 'rafamadriz/friendly-snippets'

  use "folke/trouble.nvim"       -- show lsp errors in buffer
  use 'simrat39/rust-tools.nvim' -- rust lsp, etc.

  -- treesitter for syntax highlighting and more
  use 'nvim-treesitter/nvim-treesitter'

  use 'vim-test/vim-test'
end)

require('leap').add_default_mappings()
require('gitsigns').setup()
require('trouble').setup({
  icons = false,
  fold_open = "v",      -- icon used for open folds
  fold_closed = ">",    -- icon used for closed folds
  indent_lines = false, -- add an indent guide below the fold icons
  signs = {
    -- icons / text used for a diagnostic
    error = "error",
    warning = "warn",
    hint = "hint",
    information = "info"
  },
  use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
})

local rt = require('rust-tools')
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          command = 'clippy'
        },
      }
    }
  },
  tools = {
    inlay_hints = {
      -- auto = false,
      only_current_line = true
    }
  }
})

require('telescope').setup({
  pickers = {
    find_files = {
      hidden = true,
      find_command = rg,
      -- search at buffer's location, not CWD
      -- cwd = require('telescope.utils').buffer_dir()
    },
    live_grep = {
      hidden = true,
      find_command = rg,
    }
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      -- hijack_netrw = true,
    },
  },
})
require('telescope').load_extension('file_browser')

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'cpp', 'rust', 'elixir', 'eex', 'go', 'html', 'lua', 'ruby', 'javascript', 'json', 'markdown',
    'python', 'typescript', 'yaml', 'toml' },
  sync_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true }
}

require('catppuccin').setup({
  flavour = 'mocha',
  no_italic = false,
  dim_inactive = {
    enabled = true,
    percentage = 0.0,
  }
})

-- vim-test
vim.g['test#strategy'] = {
  nearest = 'neovim',
  file = 'neovim',
  suite = 'basic',
}
