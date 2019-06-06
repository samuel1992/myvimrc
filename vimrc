syntax on
set nocompatible              " be iMproved, required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-rails'
Plugin 'mattn/emmet-vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'
Plugin 'rking/ag.vim'
Plugin 'w0rp/ale'

Bundle 'Valloric/YouCompleteMe'

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

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Leader
let mapleader = " "

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

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Make easy to navigate
set relativenumber

" enable list of completion
set wildmode=list:longest,list:full

" skip tmp files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.cache

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Disable youcompleteme preview
set completeopt-=preview

" Make my python code look pretty
let python_highlight_all=1

" Make neovim recognize my ruby gems
let g:ruby_host_prog = 'rvm system do neovim-ruby-host'

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  " autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  let g:ctrlp_user_command =
      \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" Default to filename searches
let g:ctrlp_by_filename = 1

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" configure syntastic syntax checking to check on open as well as save
" let g:syntastic_check_on_open=1
" let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" let g:syntastic_eruby_ruby_quiet_messages =
"     \ {"regex": "possibly useless use of a variable in void context"}
" let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

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

set background=dark

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" NERDTree toggle
nmap <silent><F2> :NERDTreeToggle<CR>

"NERDTree ignore
let NERDTreeIgnore = ['\.pyc$']

" New tab
map T :tabnew<CR>

" Switch splits easy
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Create splits easy
map <silent>ss :split<CR>
map <silent>vv :vsplit<CR>

" Create terminal in split
map <silent>tss :split term://bash<CR>:resize -10<CR>
map <silent>tvv :vsplit term://bash<CR>:vertical resize -30<CR>

" Clean words that was searched
map <silent>// :noh<CR>

" Go file in new vertical split
map <silent>gvv :vsplit<CR>gf

" Go file in new horizontal split
map <silent>gss :split<CR>gf

" Go file in new tab
map <silent>gtt :tabnew<CR><C-O>gf<CR>

" Set relative number
map <silent>nn :set relativenumber!<CR>

" Remapping CtrlP
" let g:ctrlp_map = ' t'
nnoremap <silent> <Leader>t :CtrlP<CR>
nnoremap <silent> <Leader>p :CtrlP<CR>
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>

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

au BufNewFile,BufRead *.vue
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set syntax=html |
    \ set textwidth=0 |
    \ set autoindent |

au BufNewFile,BufRead *.go
    \ set textwidth=0

" Incovenient blank spaces
:highlight BadWhitespace ctermfg=16 ctermbg=253 guifg=#000000 guibg=#F8F8F0
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Modify silver seacher to not open the first found
ca Ag Ag!
ca ag Ag!

" Grep the current word using K
nnoremap <silent> K :Ag! <cword><CR>

" ESC to escape in terminal split
tnoremap <Esc> <C-\><C-n>
