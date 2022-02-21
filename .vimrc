"default theme, keep all others in opt directory instead of start
packadd! dracula
"italics not supported in zsh, causes block highlighting
let g:dracula_italic = 0
colorscheme dracula
highlight Normal ctermbg=None
"syntax enable

"Shift + Tab inserts a tab character (makefiles)
inoremap <S-Tab> <C-V><Tab>

"vimwiki
set nocompatible
filetype plugin on
let g:vimwiki_list = [{ 'path': '~/Documents/notes/',
       \ 'syntax':'markdown', 'ext': '.md' }]

"allows local syntax for vimwiki
autocmd FileType vimwiki set ft=markdown 

"turns off text folding for vim-markdown
let g:vim_markdown_folding_disabled = 1

" Easily compile java 
autocmd FileType java set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C.%#

set nu
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set ai
set hlsearch
set ruler
set hidden
set termguicolors
hi Search ctermfg=black 
hi Search ctermbg=yellow
