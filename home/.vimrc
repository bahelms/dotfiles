set nocompatible               " be iMproved
filetype off
set noswapfile

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle required! 
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-haml'
Bundle 'kchmck/vim-coffee-script'
Bundle 'honza/vim-snippets'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-commentary'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'
Bundle 'skalnik/vim-vroom'
Bundle 'cakebaker/scss-syntax.vim'
" Bundle 'thoughtbot/vim-rspec'
" Bundle 'scrooloose/nerdcommenter'
" Bundle 'johnallen3d/vim-colorschemes'
" end Vundle

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

syntax on
filetype plugin indent on      " required!
syntax enable

let mapleader=","
autocmd FileType apache set commentstring=#\ %s

" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

" Uses spaces instead of tabs, Softtabs, 2 spaces
set expandtab
set tabstop=2
set shiftwidth=2

set splitbelow
set splitright
set pastetoggle=<leader>p
set number                " show line numbers

" Easier shortcuts
" Open file without retyping full path
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR><CR>
nnoremap <Leader>q :qa!<CR>
nnoremap <Leader>x :xa<CR>

" Set ruby compiler
autocmd FileType ruby compiler ruby
nnoremap <leader>f :!ruby %:p<CR>

" Start NERDTree on vim start
" autocmd vimenter * NERDTree

" Colorscheme
set t_Co=256
colorscheme railscasts

highlight ColorColumn ctermbg=233
set colorcolumn=80        " show column 80

" Window navigation
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

" Select all with ctrl-a
map <C-A> ggVG

" No arrow keys for you
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
