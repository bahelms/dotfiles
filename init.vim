filetype off
set noswapfile

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ervandew/supertab'
Plug 'Lokaltog/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'wesQ3/vim-windowswap'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'rakr/vim-one'  " colorscheme
Plug 'mhinz/vim-mix-format'
Plug 'neomake/neomake'
Plug 'slashmili/alchemist.vim'
Plug 'fatih/vim-go'
Plug 'mattn/emmet-vim'  " expand HAML syntax to HTML
Plug 'jakwings/vim-pony'
Plug 'ruanyl/vim-fixmyjs'  " automatically fix JS with eslint
Plug '/usr/local/opt/fzf' " fuzzy file finder installed with Homebrew
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
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
au FocusGained * :checktime
au VimResume * :checktime

let mapleader=","

" Colorscheme
set termguicolors
colorscheme one
set background=dark
" Airline config
" let g:airline_theme='bubblegum'
" highlight Normal guibg=#1F242E
highlight Normal guibg=#171B22

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
set ignorecase
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

" Remap inline find commands
nnoremap z m
nnoremap M ,
nnoremap m ;
vnoremap M ,
vnoremap m ;

" Remap : command
nnoremap ; :
vnoremap ; :

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

" Neovim terminal mode
if has('nvim')
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

" vim-mix-format
let g:mix_format_on_save = 1

" neomake
" Stop using pylama and use pylava
call neomake#config#set('ft.python.pylama.exe', 'pylava')
" execute when buffer is saved
augroup localneomake
  autocmd! BufWritePost * Neomake
augroup END

" Alchemist
" test current file
let g:alchemist_keyword_map = '<leader>K'
map <Leader>t :Mix test %<CR>
imap <Leader>g <C-x><C-o>

" vim-go
let g:go_fmt_command = 'goimports'

" emmet-vim
" <C-y> then ,
" let g:user_emmet_leader_key = '<c-e>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

" Fixmyjs
" autocmd BufWritePost *.js,*.jsx :Fixmyjs
 
" FZF
nnoremap <C-p> :<C-u>FZF<CR>
