require('plugins')
require('lsp')

-- vim.cmd([[
-- filetype plugin indent on
-- syntax enable
-- ]])
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
vim.cmd('colorscheme dracula')
vim.cmd.highlight('Search', 'guibg=#d665cf')
vim.cmd.highlight('ColorColumn', 'ctermbg=235 guibg=#33334d')
vim.cmd.highlight('Normal', 'guibg=none')
vim.cmd.highlight('Normal', 'guifg=#d8d8d8')

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
