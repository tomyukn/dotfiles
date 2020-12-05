scriptencoding utf-8
set encoding=utf-8

set nocompatible

" Setup Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'cocopon/iceberg.vim'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
call plug#end()

" General
if has("autocmd")
  filetype plugin indent on
  set autoindent
endif

if &t_Co > 2 || !has("gui_running")
  set t_Co=256
  syntax on
  set listchars=tab:\▸\-,trail:-
  set list
endif

set nobackup
set ruler
set cursorline
set noshowcmd
set noshowmode
set incsearch
set hlsearch
set ignorecase
set smartcase
set number
set tabstop=4
set expandtab
set shiftwidth=4
set laststatus=2
set foldlevel=100
set splitbelow
set splitright
set scrolloff=3
set viminfo+=n~/.vim/viminfo

let mapleader=","
noremap \ ,
nnoremap j gj
nnoremap k gk
nmap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

colorscheme iceberg
let g:lightline={'colorscheme': 'iceberg'}

" NERDTree
nnoremap <silent> <C-n> :NERDTreeToggle<CR>

" ale
let g:lightline#ale#indicator_checking = ".."
let g:lightline#ale#indicator_warnings = "⚠"
let g:lightline#ale#indicator_errors = "⤫"

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \  'linter_checking': 'left',
      \  'linter_warnings': 'warning',
      \  'linter_errors': 'error',
      \  'linter_ok': 'left',
      \ }

let g:lightline.active = {
      \  'right': [
      \    [ 'lineinfo' ],
      \    [ 'percent' ],
      \    [ 'fileformat', 'fileencoding', 'filetype' ],
      \    [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]
      \  ],
      \ }
