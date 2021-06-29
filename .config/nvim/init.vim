filetype plugin indent on
set noswapfile
set nocompatible

call plug#begin('~/.local/share/nvim/plugged')
" languages
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-projectionist'
Plug 'ervandew/supertab'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips' " snippet engine but no snippets
Plug 'honza/vim-snippets' " snippets to be used by an engine
Plug 'wesQ3/vim-windowswap'
Plug 'dense-analysis/ale'
Plug 'mhinz/vim-mix-format'
" Plug 'ruanyl/vim-fixmyjs'  " automatically fix JS with eslint
Plug 'rakr/vim-one'  " colorscheme
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'prettier/vim-prettier', {
      \ 'do': 'yarn install',
       \ 'for': ['typescript', 'javascript', 'css', 'scss', 'json', 'html', 'yaml', 'markdown'] }
Plug 'airblade/vim-gitgutter' "show Git changes in gutter
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-test/vim-test'
call plug#end()

" Plug help
" :PlugInstall  - install plugins
" :PlugUpdate   - update plugins
" :PlugClean!   - remove unused plugins
" :PlugUpgrade  - update vim-plug

" syntax on
syntax enable
set backspace=0
set shell=bash
set encoding=utf-8
set title

" Detect external file changes
au FocusGained,VimResume * :checktime

" let mapleader=","
let mapleader=" "

" Colorscheme
set termguicolors
" colorscheme one
colorscheme dracula
set background=dark
" highlight Normal guibg=#011627
highlight Normal guibg=none
highlight Normal guifg=#d8d8d8

set guicursor=
set noerrorbells

" Uses spaces instead of tabs, Softtabs, 2 spaces
set expandtab
set tabstop=4
set shiftwidth=2
set shiftround " multiples of shiftwidth to indent which removes offby1 indents

" For Go
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4

set splitbelow
set splitright
set pastetoggle=<Leader>[
set number relativenumber " show relative line numbers and current line no
set laststatus=2          " always show status line
set clipboard=unnamedplus " all yanks go to clipboard

" Highlight searching and cancel highlight
set hlsearch
nmap <Leader>h :noh<CR>
hi Search guibg=#d665cf

" Set 80 character line
highlight ColorColumn ctermbg=235 guibg=#33334d
set colorcolumn=80        " show column 80

" REMAPS
" Window navigation for Dvorak
nmap <C-H> <C-W><C-H>
nmap <C-K> <C-W><C-K>
nmap <C-J> <C-W><C-J>
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
nmap <Leader><BS> :wa<CR>
nmap <Leader>v <C-w>v
nmap <Leader>l <C-w>s


" Fast return
nnoremap K i<CR><ESC>

" Easier line ends nav
nnoremap H ^
nnoremap L $

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
" func! DeleteTrailingWS()
"   " Preparation - save last search, and cursor position.
"   let _s=@/
"   let l = line(".")
"   let c = col(".")
"   " Do the business:
"   %s/\s\+$//e
"   " Clean up - restore previous search history, and cursor position
"   let @/=_s
"   call cursor(l, c)
" endfunc
" autocmd BufWritePre *.rb,*.js,*.es6,*.coffee,*.haml,*.cjsx,*.ex,*.exs,*.py :call DeleteTrailingWS()
autocmd BufWritePre *.rb,*.js,*.es6,*.coffee,*.haml,*.cjsx,*.ex,*.exs,*.py :%s/\s\+$//e

" CoffeeScript 2 space indentation
" au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
" set t_ti= t_te=

" Speedups
let html_no_rendering=1   " Don't render HTML in vim
set lazyredraw

" The Silver Searcher
nnoremap \ :Ag<SPACE>
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(
      \   <q-args>,
      \   ' --hidden ',
      \  <bang>0 ? fzf#vim#with_preview('up:60%')
      \        : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0
      \ )

" vim-mix-format
let g:mix_format_on_save = 1

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
  autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx,*.css,*.scss,*.json,*.md,*.yaml PrettierAsync
endif

" gitgutter
set updatetime=100

" fzf
" let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
map <Leader>i :Files<CR>

" rust.vim
let g:rustfmt_autosave = 1

" coc
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gr <Plug>(coc-references)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

" ale
let g:ale_fix_on_save = 1

" projectionist
nmap <Leader>tt :A<CR>
nmap <Leader>tv :AV<CR>

" vim-test
nmap <Leader>tn :TestNearest<CR>
nmap <Leader>tf :TestFile<CR>

" Ultisnip
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
