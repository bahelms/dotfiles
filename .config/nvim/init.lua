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
  use 'airblade/vim-gitgutter' --show Git changes in gutter
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {'dracula/vim', as = 'dracula'} -- colorscheme
end)

vim.cmd([[
filetype plugin indent on
syntax enable
]])
vim.g.mapleader = " "

require("mappings")

vim.opt.swapfile = false
vim.opt.compatible = false
vim.opt.backspace = "0"
vim.opt.encoding = "utf-8"
vim.opt.title = true
vim.opt.fileformats = 'unix'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamedplus' -- all yanks go to clipboard
vim.opt.hlsearch = true
vim.cmd('hi Search guibg=#d665cf')
vim.opt.guicursor = ''
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 2
vim.opt.shiftround = true -- multiples of shiftwidth to indent which removes offby1 indents
vim.opt.laststatus = 2 -- always show status line

-- visual
vim.opt.termguicolors = true
vim.opt.background = dark
vim.opt.lazyredraw = true -- speedup
vim.g.html_no_rendering = 1 -- don't render HTML in vim
vim.opt.colorcolumn = '80'
vim.cmd([[
colorscheme dracula
highlight ColorColumn ctermbg=235 guibg=#33334d
highlight Normal guibg=none
highlight Normal guifg=#d8d8d8
]])

-- delete trailing whitespace
vim.cmd('autocmd BufWritePre *.c,*.rs,*.lua,*.rb,*.js,*.es6,*.coffee,*.haml,*.cjsx,*.ex,*.exs,*.py :%s/\\s\\+$//e')

-- terminal
vim.cmd([[
highlight! link TermCursor Cursor
highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
]])

-- spacing for Go's stupid two-tab indentation
vim.cmd([[
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
]])

-- package config

-- rust.vim
vim.g.rustfmt_autosave = 1

-- gitgutter
vim.opt.updatetime = 100
