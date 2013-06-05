" Configuration file for VIM
" Author: valentin@quelltextfabrik.de
" Created: 04.06.2013
" Inspiration:
"   * https://github.com/docwhat/homedir-vim/blob/master/vimrc/.vimrc

" Remove all autocmds, so they are not loaded twice
if has("autocmd")
  autocmd!
endif

" --- Options  ---------------------------------------------------------------
" --- Misc options
set nocompatible          " Enable all the cool stuff
scriptencoding utf-8

" --- Tab and whitespace options
set smarttab                      " TODO find out, what that setting does
set tabstop=2                     " Default tab stops
set shiftwidth=2                  " Default auto indent
set softtabstop=2
set expandtab                     " Use spaces instead of tabs
set autoindent                    " Use indent from previous line
set backspace=indent,eol,start    " If backspace was any smarter it'd send a terminator back in time

" --- Display options
syntax on
set number                                " Display line numbers
set cursorline                            " Highlight current line

set nowrap                                " Soft wrapping, without changing text
set linebreak                             " Only break on characters in 'breakat'
if has('multi_byte')                      " Use fancy symbols to indicate linebreak
  let &showbreak = '↳ '
else
  let &showbreak = '> '
endif

set showmatch                             " Show matching bracket
set matchpairs=(:),[:],{:}                " Expected pairs

set laststatus=2                          " Always show status line
set cmdheight=2                           " Command line two lines high
set scrolloff=5                           " Keep at least 5 lines above/below
set sidescrolloff=5                       " Keep at least 5 lines left/right

set list listchars=tab:»·,trail:·,nbsp:+  " Show the leading whitespaces"
set display+=uhex                         " Show unprintables as <xx>
set display+=lastline                     " Show as much as possible of the last line

" --- Search options
set ignorecase    " Ignore case when searching
set smartcase     " Except when uppercase is used
set incsearch     " Show matches live while typing
set hlsearch      " Highlight all search matches, turn off with :noh

" --- Auto complete options
set wildmode=list:longest,full  " TODO document the awesomeness of this
set wildmenu
set wildignore+=*.o,*.obj,*.pyc,*.pyo,*.pyd,*.class,*.lock
set wildignore+=*.png,*.gif,*.jpg,*.ico
set wildignore+=',.svn,.hg
set showcmd                     " Display incomplete commands

" --- Buffer and backup options
set hidden                " Hide buffer instead of unloading when abandoning it
set history=1000          " Keep more history of : commands
set undolevels=1000       " 1000 undos
set updatecount=100       " Switch swap file every 160 chars

set autoread              " Reload file in VIM if changed outside and not changed in VIM

" Create a tmp folder in the home directory for swap, backup and undo files
if isdirectory($HOME . '/tmp') == 0
  :silent !mkdir -p ~/tmp > /dev/null 2>&1
endif

set backupdir=~/tmp
set backup
set directory=~/tmp
set swapfile
if exists("+undofile")
  set undodir=~/tmp
  set undofile
endif

" --- Vundler ----------------------------------------------------------------
" This section should setup VIM with very little interaction, vundle and
" the specified Bundles are installed autmatically
"
" Run manually after BundleInstall: .vim/bundle/YouCompleteMe/install.sh --clang-completer

" --- Function to install bundles automagically
function! LoadBundles()
  " let Vundle manage Vundle
  Bundle 'gmarik/vundle'

  Bundle 'Lokaltog/vim-powerline'
  Bundle 'kien/ctrlp.vim'
  Bundle 'Valloric/YouCompleteMe'
  Bundle 'tpope/vim-endwise'
  Bundle 'jiangmiao/auto-pairs'
  Bundle 'terryma/vim-multiple-cursors'
  Bundle 'tomtom/tcomment_vim'
  Bundle 'scrooloose/syntastic'
  Bundle 'tpope/vim-haml'
  Bundle 'tpope/vim-rails'
  Bundle 'vim-ruby/vim-ruby'
  Bundle 'tpope/vim-sensible'
  Bundle 'cakebaker/scss-syntax.vim'
  Bundle 'mattn/zencoding-vim'
  Bundle 'tpope/vim-fugitive'
endfunction

" --- Install Vundle and bundles if possible
filetype off                            " required!
if executable("git")
  if !isdirectory(expand("~/.vim/bundle/vundle"))
    echomsg "***************************"
    echomsg "Installing Vundle"
    echomsg "***************************"
    !mkdir -p ~/.vim/bundle && git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    let s:bootstrap=1
  endif

  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()
  call LoadBundles()

  if exists("s:bootstrap") && s:bootstrap
    unlet s:bootstrap
    BundleInstall
    quit
  endif
endif

filetype plugin indent on               " required!

" --- Eyecandy ---------------------------------------------------------------
" --- Color and color scheme
set t_Co=256                  " Enable 256 colors
set background=dark           " Prefer dark background
colorscheme wombat256mod_vk   " Chose most awesome theme here

" --- VIM Powerline options
let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme = 'vk'

" --- Plugin options ---------------------------------------------------------
" --- CtrlP plugin for fuzzy file finding
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" --- Helpers ----------------------------------------------------------------
" --- Always jump to last known position if valid
if has ("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g `\"" |
    \ endif
endif

" --- Strip trailing whitespace
function! StripTrailingWhite()
  let l:winview = winsaveview()
  silent! %s/\s\+$//
  call winrestview(l:winview)
endfunction
if has("autocmd")
  autocmd BufWritePre *  call StripTrailingWhite()
endif

" --- Syntax specific settings -----------------------------------------------
" --- Ruby
if has("autocmd")
  autocmd FileType ruby,eruby setlocal cinwords=do
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading=1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global=1
endif

" --- C,C++,ObjC
if has("autocmd")
  autocmd FileType java,c,cpp,objc setlocal smartindent tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType java,c,cpp,objc let b:loaded_delimitMate = 1
endif

" --- Markdown
if has("autocmd")
  autocmd BufNewFile,BufRead *.mdwn,*.mkd,*.md,*.markdown setlocal filetype=markdown
  autocmd FileType markdown setlocal tabstop=4 shiftwidth=4 softtabstop=4
endif

" --- Finish up --------------------------------------------------------------
set secure
" EOF
