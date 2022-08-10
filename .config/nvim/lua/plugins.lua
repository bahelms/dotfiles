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

  use 'tpope/vim-commentary' -- comments
  use 'tpope/vim-fugitive' -- Git commands
  use 'tpope/vim-projectionist'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-vinegar' -- file tree
  use 'easymotion/vim-easymotion'
  use 'sheerun/vim-polyglot'
  use 'jiangmiao/auto-pairs'
  use 'wesQ3/vim-windowswap'
  use 'lewis6991/gitsigns.nvim' -- show git changes in gutter, manage hunks
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use { -- fuzzy finder
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'dracula/vim', as = 'dracula'} -- colorscheme

  -- lsp - language server protocol
  use {'neovim/nvim-lspconfig'}
  use {'hrsh7th/nvim-cmp'} -- cmp framework for auto-completion support

  -- install different completion source
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-path'}
  use {'hrsh7th/cmp-cmdline'}

  -- you need a snippet engine for snippet support
  -- here I'm using vsnip which can load snippets in vscode format
  use {'hrsh7th/vim-vsnip'}
  use {'hrsh7th/cmp-vsnip'}

  use "folke/trouble.nvim" -- show lsp errors in buffer
  use 'simrat39/rust-tools.nvim' -- rust lsp, etc.

  -- treesitter for syntax highlighting and more
  -- use {
  --   'nvim-treesitter/nvim-treesitter',
  --   run = function() require('nvim-treesitter.install').update({ with_sync = true }) end
  -- }
end)

require('gitsigns').setup()
require('trouble').setup({
  icons = false,
  fold_open = "v", -- icon used for open folds
  fold_closed = ">", -- icon used for closed folds
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
        }
      }
    }
  },
})
