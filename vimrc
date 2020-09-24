syntax on
set nocompatible              " be iMproved, required

" Set Ale linters
let g:ale_linters = {
\   'python': ['flake8'],
\}

command! MakeTags !ctags -R .
" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-rails'
Plugin 'elixir-editors/vim-elixir'
Plugin 'fatih/vim-go'
Plugin 'mattn/emmet-vim'
Plugin 'rking/ag.vim'
Plugin 'dyng/ctrlsf.vim'
Plugin 'w0rp/ale'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'JamshedVesuna/vim-markdown-preview'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Leader
let mapleader = " "

set path+=**
set wildmenu
set wildignore+=*pyc
set encoding=utf-8 " Ensure to work with utf-8, better to my python/django projects
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=1000  " a lot of history
set ruler         " show the cursor position all the time
set hlsearch
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set ignorecase    " Ignore case when searching...
set smartcase     " ...unless we type a capital
set showmode      "Show current mode down the bottom
set visualbell    " No noise
set nowrap        "Don't wrap lines
set background=dark "Dark colors
set tabstop=2 " Softtabs, 2 spaces
set shiftwidth=2
set shiftround
set expandtab
set textwidth=80 " Make it obvious where 80 characters is
set colorcolumn=+1
set number
set numberwidth=5
set relativenumber
set foldmethod=syntax
set foldlevel=99
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
set splitbelow " Open new split panes to the bottom
set splitright " Open new split panes to the right
set tags=tags

" Make my python code look pretty
let python_highlight_all=0

" Make neovim recognize my ruby gems
let g:ruby_host_prog = 'rvm system do neovim-ruby-host'

filetype plugin indent on

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" New tab
map T :tabnew<CR>

" Switch splits easy
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Mapping next and previous tab
nnoremap <silent><space><space> :tabnext<CR>

" Create splits easy
nnoremap <silent>ss :split<CR>
nnoremap <silent>vv :vsplit<CR>

" Create terminal in split
nnoremap <silent>tss :term<CR>
nnoremap <silent>tvv :vertical term<CR>

" Clean words that was searched
nnoremap <silent>// :noh<CR>

" Go file in new vertical split
nnoremap <silent>gvv :vsplit<CR>gf

" Go file in new horizontal split
nnoremap <silent>gss :split<CR>gf

" Go file in new tab
nnoremap <silent>gtt :tabnew<CR><C-O>gf<CR>

" Mapping copy and paste with X support
noremap <Leader>y "+y
noremap <Leader>p "+p

" Python PEP 8 identation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Vue files with html syntax
au BufNewFile,BufRead *.vue
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set syntax=html |
    \ set textwidth=0 |
    \ set autoindent |

" Text to go
au BufNewFile,BufRead *.go
    \ set textwidth=0

" Text limiter to markdown
au BufNewFile,BufRead *.md
    \ set textwidth=168

au BufNewFile,BufRead *.html
    \ set textwidth=0

" Incovenient blank spaces
highlight BadWhitespace ctermfg=16 ctermbg=253 guifg=#000000 guibg=#F8F8F0
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.go,*.rb match BadWhitespace /\s\+$/

" Modify silver seacher to not open the first found
ca Ag Ag!
ca ag Ag!

" Ag find the current word using K
nnoremap <silent> K :Ag! <cword><CR>

let g:ctrlsf_winsize = '30%' " ctrlsf position

" Shortcutt to CtrlSF a word
map <silent>F <Plug>CtrlSFPrompt<CR>

" Initial configuration for Explore
let g:netrw_winsize = 17
let g:netrw_banner=0        " disable annoying banner
" let g:netrw_browse_split=2  " open in vertical split
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view

"Netwr was removind my ctrl L command
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END
function! NetrwMapping()
  nnoremap <buffer> <c-l> :wincmd l<cr>
endfunction
