vim.opt.termguicolors = true

require('plugins')
require('lsp')

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
vim.opt.scrolloff = 8
vim.opt.guicursor = ''
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 2
vim.opt.shiftround = true   -- multiples of shiftwidth to indent which removes offby1 indents
vim.opt.laststatus = 2      -- always show status line
vim.opt.lazyredraw = true   -- speedup
vim.g.html_no_rendering = 1 -- don't render HTML in vim

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
