set nocompatible               " be iMproved
filetype off
set noswapfile

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle required! 
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-haml'
Bundle 'kchmck/vim-coffee-script'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'honza/vim-snippets'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-commentary'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'
Bundle 'skalnik/vim-vroom'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'groenewege/vim-less'
Bundle 'juvenn/mustache.vim'
Bundle 'thoughtbot/vim-rspec'
Bundle 'AndrewRadev/splitjoin.vim'
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
syntax enable
filetype plugin indent on      " required!

let mapleader=","
autocmd FileType apache set commentstring=#\ %s

" Colorscheme
set t_Co=256
colorscheme railscasts
" colorscheme tomorrow_night

" Show active window through bars
highlight StatusLine   ctermfg=253 ctermbg=232
highlight StatusLineNC ctermfg=237 ctermbg=15
highlight VertSplit    ctermfg=237 ctermbg=0

" Highlight cursor lines
" set cursorline
" highlight CursorLine ctermbg=234

set noerrorbells

" Uses spaces instead of tabs, Softtabs, 2 spaces
set expandtab
set tabstop=2
set shiftwidth=2

set splitbelow
set splitright
set pastetoggle=<leader>p
set number                " show line numbers
set laststatus=2          " always show status line

" Highlight searching and cancel highlight
set hlsearch
nmap <leader>h :noh<CR> 

" ctrlp shortcuts
nmap <leader>f <C-P>
nmap <leader>v <C-V>
nmap <leader>s <C-X>

" NERDTree
" autocmd vimenter * NERDTree  " Start NERDTree on vim start
let NERDTreeShowHidden = 1
let NERDTreeHighlightCursorline = 0

" Set 80 character line
highlight ColorColumn ctermbg=235 guibg=#262626
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
nnoremap <Leader>q :qa!<CR>
nnoremap <Leader>x :xa<CR>
nnoremap <Leader>g "0p
vnoremap <Leader>g "0p

" Window resizing
" nnoremap - <C-W>-
" nnoremap + <C-W>+

" Select all with ctrl-a
nnoremap <D-a> <C-a>
nnoremap <C-a> ggVG

" Fast return
nnoremap K i<CR><ESC>

" split/join command
nnoremap <Leader>s gS
nnoremap <Leader>j ^gJ


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
autocmd BufWritePre *.rb :call DeleteTrailingWS()

" CoffeeScript 2 space indentation
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

set t_ti= t_te=

" Speedups
let html_no_rendering=1   " Don't render HTML in vim
set lazyredraw


" Tests in Vim
"
" Test in file with Spring
nmap <leader>r :call vroom#RunTestFile({'runner':'bin/rspec %'})<CR>
"
" Send test to Spin server
nmap <leader>s :!spin push % <CR><CR>
"
" Run rspec normally in Vim with vim-rspec
let g:rspec_command = "!clear && echo bundle exec rspec {spec} && bundle exec rspec {spec}"
let g:rspec_runner = "ox_x_iterm"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>n :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

