execute pathogen#infect()
syntax on
filetype plugin indent on

set t_Co=256
colorscheme wombat256mod_vk

set number
set cursorline

" VIM Powerline for a more powerful statusbar
set nocompatible
set laststatus=2
set encoding=utf-8
let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme = 'vk'

" CtrlP plugin for fuzzy file finding
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

set tabstop=2
set shiftwidth=2
set expandtab                 " expand tabs to spaces
set smarttab
set showcmd
set autoindent
set nowrap
set autoread                  " watch for file changes

set scrolloff=5               " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right

set incsearch                 " Use search for replace so you can do /old then :%s//new
set hlsearch

set cmdheight=2               " command line two lines high
set undolevels=1000           " 1000 undos
set updatecount=100           " switch every 100 chars
set hlsearch                  " highlight the last searched term


set backup
set backupdir=/home/vk/tmp
set directory=/home/vk/tmp
set swapfile
set dir=/home/vk/tmp

" Reveal syntax groups
" Show syntax highlighting groups for word under cursor
nmap <F2> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

