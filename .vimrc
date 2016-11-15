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
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-haml'
Bundle 'kchmck/vim-coffee-script'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'honza/vim-snippets'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-commentary'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-surround'
Bundle 'skalnik/vim-vroom'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'groenewege/vim-less'
Bundle 'ElmCast/elm-vim'
Bundle 'thoughtbot/vim-rspec'
Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'elixir-lang/vim-elixir'
Bundle 'SirVer/ultisnips'
Bundle 'dockyard/vim-easydir'
Bundle 'mtscout6/vim-cjsx'
Bundle 'mrtazz/simplenote.vim'
Bundle 'wesQ3/vim-windowswap'
Bundle 'jiangmiao/auto-pairs'
Bundle 'scrooloose/syntastic'
Bundle 'derekwyatt/vim-scala'
Bundle 'hdima/python-syntax'
Bundle 'nvie/vim-flake8'
Bundle 'ludovicchabant/vim-gutentags'
Bundle 'majutsushi/tagbar'
Bundle 'gabrielelana/vim-markdown'
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
set backspace=0
set shell=bash
set encoding=utf-8

let ruby_space_errors = 1
let python_highlight_all = 1

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
autocmd FileType apache set commentstring=#\ %s

" Colorscheme
set t_Co=256
colorscheme railscasts

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
set pastetoggle=<leader>[
set number                " show line numbers
set laststatus=2          " always show status line

" Highlight searching and cancel highlight
set hlsearch
nmap <leader>h :noh<CR>

" Saving/restoring sessions
noremap <F2> :mksession! ~/.vim_session<CR>
noremap <F3> :source ~/.vim_session<CR>

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
nmap <Leader>a <F2>:wa<CR>

" Window resizing
" nnoremap - <C-W>-
" nnoremap + <C-W>+

" Select all with ctrl-a
" nnoremap <D-a> <C-a>
" nnoremap <C-a> ggVG

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
autocmd BufWritePre *.rb,*.js,*.coffee,*.haml,*.cjsx,*.ex,*.exs,*.py,*.md :call DeleteTrailingWS()
map <Leader>f :call DeleteTrailingWS()<CR><Leader>a

" CoffeeScript 2 space indentation
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

set t_ti= t_te=

" Speedups
let html_no_rendering=1   " Don't render HTML in vim
set lazyredraw


" Tests in Vim
"
" Run mix test for current file
" nmap <leader>s :!mix test <C-R>=expand('%:p')<CR><CR>

" Run rspec normally in Vim with vim-rspec
let g:rspec_command = "!clear && echo bundle exec rspec {spec} && bundle exec rspec {spec}"
let g:rspec_runner = "ox_x_iterm"
map <Leader>n :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>

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
nmap <Leader>sl :Simplenote -l<CR>
nmap <Leader>sn :Simplenote -n<CR>
nmap <Leader>su :Simplenote -u<CR>
nmap <Leader>sd :Simplenote -d<CR>
nmap <Leader>sD :Simplenote -D<CR>

" Vim Markdown 

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
