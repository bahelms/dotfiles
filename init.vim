set nocompatible               " be iMproved
filetype off
set noswapfile

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

" let Vundle manage Vundle required!
Bundle 'VundleVim/Vundle.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'ervandew/supertab'
Bundle 'skalnik/vim-vroom'
Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'dockyard/vim-easydir'
Bundle 'ludovicchabant/vim-gutentags'
Bundle 'majutsushi/tagbar'
Bundle 'slim-template/vim-slim'
" end Vundle
" :BundleInstall(!)    - install(update) bundles
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles

call plug#begin('~/.local/share/nvim/plugged')
" Plug 'jiangmiao/auto-pairs'
Plug 'kien/ctrlp.vim'
Plug 'rakr/vim-one'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'wesQ3/vim-windowswap'

" Languages
Plug 'cakebaker/scss-syntax.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'jelera/vim-javascript-syntax'
Plug 'kchmck/vim-coffee-script'
Plug 'mtscout6/vim-cjsx'
Plug 'rhysd/vim-crystal'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rails'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
call plug#end()

" Plug help
" :PlugInstall  - install plugins
" :PlugUpdate   - update plugins
" :PlugClean!   - remove unused plugins
" :PlugUpgrade  - update vim-plug

syntax on
syntax enable
filetype plugin indent on      " required!
set backspace=0
set shell=bash
set encoding=utf-8

" Remap inline find commands
nnoremap z m
nnoremap M ,
nnoremap m ;
vnoremap M ,
vnoremap m ;

" Remap : command
nnoremap ; :
vnoremap ; :

let mapleader=","

" Colorscheme
set termguicolors
" colorscheme firewatch
colorscheme one
set background=dark
" Airline config
let g:airline_theme='bubblegum'
highlight Normal guibg=#1F242E

set guicursor=
set noerrorbells

" Uses spaces instead of tabs, Softtabs, 2 spaces
set expandtab
set tabstop=2
set shiftwidth=2

set splitbelow
set splitright
set pastetoggle=<leader>[
set number                " show line numbers
set laststatus=2          " always show status line

" Highlight searching and cancel highlight
set hlsearch
nmap <leader>h :noh<CR>

" NERDTree
" autocmd vimenter * NERDTree  " Start NERDTree on vim start
let NERDTreeShowHidden = 1
let NERDTreeHighlightCursorline = 0
map <C-n> :NERDTreeToggle<CR>

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
nmap <F1> <ESC>

" Easier shortcuts
" Open file without retyping full path
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR><CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>x :xa<CR>
nmap <Leader>a :wa<CR>

" Fast return
nnoremap K i<CR><ESC>

" Yank/delete remaps
" Yank line into register "0 and ""
nmap - ^y$
vmap - y
" Paste yank
map = "0p
" Delete line into register ""
nmap _ ^"1D
vmap _ "1D
" Paste delete
map + "1p

" Visual yank to clipboard
vnoremap <Leader>c "+y

" Easier line ends nav
nnoremap H ^
nnoremap L $

" No arrow keys for you
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Send cursor to end of line from insert mode
inoremap <C-\> <ESC>A

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
autocmd BufWritePre *.rb,*.js,*.coffee,*.haml,*.cjsx,*.ex,*.exs,*.py :call DeleteTrailingWS()
map <Leader>f :call DeleteTrailingWS()<CR><Leader>a

" CoffeeScript 2 space indentation
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
set t_ti= t_te=

" Speedups
let html_no_rendering=1   " Don't render HTML in vim
set lazyredraw

" UltiSnips config
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Add search path
let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME."/dotfiles/UltiSnips"]

" Simplenote
source ~/.simplenoterc
nmap <Leader>sl :SimplenoteList<CR>
nmap <Leader>su :SimplenoteUpdate<CR>
nmap <Leader>sn :SimplenoteNew<CR>
nmap <Leader>sd :SimplenoteTrash<CR>
nmap <Leader>sD :SimplenoteDelete<CR>

" The Silver Searcher
if executable('ag')
	" Use ag over grep
	set grepprg=ag
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	let g:ctrlp_use_caching = 0

	" bind \ to grep shortcut
	command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
	nnoremap \ :Ag<SPACE>
endif

" Tagbar
map <Leader>t :TagbarToggle<CR>
" Ctags
nmap <C-\> <C-t>