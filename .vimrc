syntax on
set relativenumber
set tabstop=4
set shiftwidth=4
"Shift + Tab inserts a tab character (makefiles)
inoremap <S-Tab> <C-V><Tab>
set expandtab
set ai
set hlsearch
set ruler
set nu
set hidden

highlight Comment ctermfg=red

"default, keep all others in opt directory instead of start
packadd! dracula
colorscheme dracula

"vimwiki
set nocompatible
filetype plugin on
let g:vimwiki_list = [{ 'path': '~/Documents/notes/',
       \ 'syntax':'markdown', 'ext': '.md' }]
"allows local syntax vimwiki
autocmd FileType vimwiki set ft=markdown 

"vim-markdown turns off text folding
let g:vim_markdown_folding_disabled = 1


" Easy compile java in vim
autocmd FileType java set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C.%#

set termguicolors
