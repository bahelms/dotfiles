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

  -- treesitter for syntax highlighting and more
  -- use {'nvim-treesitter/nvim-treesitter'}
end)
