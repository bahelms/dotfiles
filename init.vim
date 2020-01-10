" filetype off
set noswapfile
set nocompatible

call plug#begin('~/.local/share/nvim/plugged')
" languages
Plug 'vim-ruby/vim-ruby'
Plug 'fatih/vim-go'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'ervandew/supertab'
Plug 'Lokaltog/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'wesQ3/vim-windowswap'
" Plug 'neomake/neomake'
Plug 'dense-analysis/ale'
Plug 'ruanyl/vim-fixmyjs'  " automatically fix JS with eslint
Plug 'rakr/vim-one'  " colorscheme
Plug 'haishanh/night-owl.vim' " theme
Plug 'prettier/vim-prettier', {
      \ 'do': 'yarn install',
      \ 'for': ['javascript', 'css', 'scss', 'json', 'html', 'yaml', 'markdown'] }
Plug 'airblade/vim-gitgutter' "show Git changes in gutter
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

" Plug help
" :PlugInstall  - install plugins
" :PlugUpdate   - update plugins
" :PlugClean!   - remove unused plugins
" :PlugUpgrade  - update vim-plug

syntax on
syntax enable
set backspace=0
set shell=bash
set encoding=utf-8
set title

" Detect external file changes
au FocusGained,VimResume * :checktime

let mapleader=","

" Colorscheme
set termguicolors
colorscheme one
set background=dark
highlight Normal guibg=#011627
highlight Normal guifg=#d8d8d8

set guicursor=
set noerrorbells

" Uses spaces instead of tabs, Softtabs, 2 spaces
set expandtab
set tabstop=4
set shiftwidth=2

" For Go
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4

set splitbelow
set splitright
set pastetoggle=<leader>[
set number relativenumber " show relative line numbers and current line no
set laststatus=2          " always show status line
set clipboard=unnamedplus " all yanks go to clipboard

" Highlight searching and cancel highlight
set hlsearch
set ignorecase

" Set 80 character line
highlight ColorColumn ctermbg=235 guibg=#33334d
set colorcolumn=80        " show column 80

" REMAPS
" Window navigation
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

"No help
" nmap <F1> <ESC>

" Remap inline find commands
nnoremap z m
nnoremap M ,
nnoremap m ;
vnoremap M ,
vnoremap m ;

" Remap : command
nnoremap ; :
vnoremap ; :

" Leader shortcuts
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>x :xa<CR>
nmap <Leader>a :wa<CR>
nmap <leader>h :noh<CR>

" Fast return
nnoremap K i<CR><ESC>

" " Yank/delete remaps
" " Yank line into register "0 and ""
" nmap - ^y$
" vmap - y
" " Paste yank
" map = "0p
" " Delete line into register ""
" nmap _ ^"1D
" vmap _ "1D
" " Paste delete
" map + "1p

" Easier line ends nav
nnoremap H ^
nnoremap L $

" No arrow keys for you
" nnoremap <Left> :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up> :echoe "Use k"<CR>
" nnoremap <Down> :echoe "Use j"<CR>

" Send cursor to end of line from insert mode
inoremap <C-\> <ESC>A

" Neovim terminal mode
if has('nvim')
  nnoremap <Leader>st :sp term://zsh<CR>
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  " Preparation - save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up - restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunc
autocmd BufWritePre *.rb,*.js,*.es6,*.coffee,*.haml,*.cjsx,*.ex,*.exs,*.py :call DeleteTrailingWS()

" CoffeeScript 2 space indentation
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
set t_ti= t_te=

" Speedups
let html_no_rendering=1   " Don't render HTML in vim
set lazyredraw

" The Silver Searcher
nnoremap \ :Ag<SPACE>

" vim-mix-format
let g:mix_format_on_save = 1

" neomake
" Stop using pylama and use pylava
" call neomake#config#set('ft.python.pylama.exe', 'pylava')
" call neomake#configure#automake('nw', 750)
" " execute when buffer is saved
" augroup localneomake
"   autocmd! BufWritePost * Neomake
" augroup END
" ESlint
" let g:neomake_javascript_enabled_makers = ['eslint']
" let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
" let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

" vim-go
let g:go_fmt_command = 'goimports'
let g:go_highlight_structs = 0
let g:go_highlight_interfaces = 0
let g:go_highlight_operators = 0
let g:go_doc_keywordprg_enabled = 0

" emmet-vim
" <C-y> then ,
" let g:user_emmet_leader_key = '<c-e>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

" Prettier
if filereadable('.prettierconfig') || filereadable('.prettierrc')
  let g:prettier#quickfix_enabled = 0
  let g:prettier#autoformat = 0
  autocmd BufWritePre *.js,*.jsx,*.css,*.scss,*.json,*.md,*.yaml PrettierAsync
endif

" gitgutter
set updatetime=100

" netrw
let g:netrw_banner=0
nnoremap <silent><leader>e :Explore<CR>

" fzf
map <Leader>f :Files<CR>
