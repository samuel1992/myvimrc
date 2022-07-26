syntax on
filetype plugin indent on

set nocompatible              " be improved, required


" set the runtime path to include vundle and initialize
set rtp+=~/.vim/bundle/vundle.vim
call vundle#begin()
" alternatively, pass a path where vundle should install plugins
"call vundle#begin('~/some/path/here')

" let vundle manage vundle, required
plugin 'vundlevim/vundle.vim'
plugin 'tpope/vim-rails'
plugin 'tpope/vim-fugitive'
plugin 'elixir-editors/vim-elixir'
plugin 'fatih/vim-go'
plugin 'mattn/emmet-vim'
plugin 'rking/ag.vim'
plugin 'dyng/ctrlsf.vim'
plugin 'w0rp/ale'
plugin 'vimjas/vim-python-pep8-indent'

" all of your plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" to ignore plugin indent changes, instead use:
"filetype plugin on
"
" brief help
" :pluginlist       - lists configured plugins
" :plugininstall    - installs plugins; append `!` to update or just :pluginupdate
" :pluginsearch foo - searches for foo; append `!` to refresh local cache
" :pluginclean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for faq
" put your non-plugin stuff after this line

" set ale linters
let g:ale_linters = {
\   'python': ['flake8'],
\}

" set ale fixers
let g:ale_fixers = {
\   'python': ['autopep8'],
\}

" leader
let mapleader = " "

" make my python code look pretty
let python_highlight_all=0

" initial configuration for explore
let g:netrw_winsize = 17
let g:netrw_banner=0        " disable annoying banner
" let g:netrw_browse_split=2  " open in vertical split
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view


set path+=**
set wildmenu
set wildignore+=*pyc,.git/**,node_modules/**,python-virtualenv/**,.venv/**
set encoding=utf-8 " ensure to work with utf-8, better to my python/django projects
set backspace=2   " backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=1000  " a lot of history
set ruler         " show the cursor position all the time
set hlsearch
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " always display the status line
set autowrite     " automatically :write before running commands
set ignorecase    " ignore case when searching...
set smartcase     " ...unless we type a capital
set showmode      "show current mode down the bottom
set visualbell    " no noise
set nowrap        "don't wrap lines
set background=dark "dark colors
set tabstop=2 " softtabs, 2 spaces
set shiftwidth=2
set shiftround
set expandtab
set textwidth=80 " make it obvious where 80 characters is
set colorcolumn=+1
set number
set numberwidth=5
set relativenumber
set foldmethod=syntax
set foldlevel=99
set list listchars=tab:»·,trail:·,nbsp:· " display extra whitespace
set splitbelow " open new split panes to the bottom
set splitright " open new split panes to the right
set tags=tags

" automatically rebalance windows on vim resize
autocmd vimresized * :wincmd =

" ================ persistent undo ==================
" keep undo history across sessions, by storing in file.
" only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" local config
if filereadable($home . "/.vimrc.local")
  source ~/.vimrc.local
endif

" new tab
map t :tabnew<cr>

" switch splits easy
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>

" mapping next and previous tab
nnoremap <silent><space><space> :tabnext<cr>

" create splits easy
nnoremap <silent>ss :split<cr>
nnoremap <silent>vv :vsplit<cr>

" create terminal in split
nnoremap <silent>tss :term<cr>
nnoremap <silent>tvv :vertical term<cr>

" clean words that was searched
nnoremap <silent>// :noh<cr>

" go file in new vertical split
nnoremap <silent>gvv :vsplit<cr>gf

" go file in new horizontal split
nnoremap <silent>gss :split<cr>gf

" go file in new tab
nnoremap <silent>gtt :tabnew<cr><c-o>gf<cr>

" mapping copy and paste with x support
noremap <leader>y "+y
noremap <leader>p "+p

" python pep 8 identation
au bufnewfile,bufread *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" vue files with html syntax
au bufnewfile,bufread *.vue
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set syntax=html |
    \ set textwidth=0 |
    \ set autoindent |

" text to go
au bufnewfile,bufread *.go
    \ set textwidth=0

" text limiter to markdown
au bufnewfile,bufread *.md
    \ set textwidth=168

au bufnewfile,bufread *.html
    \ set textwidth=0

" incovenient blank spaces
highlight badwhitespace ctermfg=16 ctermbg=253 guifg=#000000 guibg=#f8f8f0
au bufread,bufnewfile *.py,*.pyw,*.c,*.h,*.go,*.rb match badwhitespace /\s\+$/

" modify silver seacher to not open the first found
ca ag ag!
ca ag ag!

" ag find the current word using k
nnoremap <silent> k :ag! <cword><cr>

let g:ctrlsf_winsize = '30%' " ctrlsf position

" shortcutt to ctrlsf a word
map <silent>f <plug>ctrlsfprompt<cr>
