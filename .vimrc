syntax on
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set ai
set hlsearch
set ruler
set nu
set hidden

highlight Comment ctermfg=red

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim',{ 'as': 'dracula' }
call plug#end()

color dracula
set termguicolors
