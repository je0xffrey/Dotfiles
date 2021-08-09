" ============== "
" ====Basics==== "
" ============== "
syntax on
set nocompatible
set smartcase
filetype plugin on
"set background=dark
set background=light
set nu
" for zsh printing unknown term codes 
set guicursor=

" Tabs
set et sw=4 ts=4 sts=4 " Default
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
autocmd FileType html :setlocal sw=2 ts=2 sts=2
autocmd FileType xml :setlocal sw=2 ts=2 sts=2
autocmd FileType typescript.tsx :setlocal sw=2 ts=2 sts=2

" Make vertical separator pretty
highlight VertSplit cterm=NONE
set fillchars+=vert:\▏


" ============== "
" ===Mappings=== "
" ============== "
let mapleader="\<Space>"

nnoremap <leader>gb :Blame<CR>
nnoremap <leader>gy :Goyo<CR>

nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nnoremap <leader>q :bd<CR>

"clipboard copy with leader
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"navigate buf with [tab] and bp with [shift+tab]
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

"GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"jump to errors in llist
nmap <Leader>j :lnext<CR>
nmap <Leader>k :lprev<CR>

"shift + k opens up documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

"Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <silent> <Leader>s <Plug>SearchNormal
vmap <silent> <Leader>s <Plug>SearchVisual


" ============="
" ===Plugins==="
" ============="
let g:ale_disable_lsp = 1
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vimwiki/vimwiki'
Plug 'pangloss/vim-javascript'    
Plug 'peitalin/vim-jsx-typescript'
Plug 'herringtondarkholme/yats.vim'
Plug 'wavded/vim-stylus'
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'StanAngeloff/php.vim'
Plug 'voldikss/vim-browser-search'
Plug 'NLKNguyen/papercolor-theme'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/goyo.vim'
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank']
call plug#end()


" ============="
" PluginConfigs"
" ============="
"colorscheme purify
colorscheme PaperColor
let g:airline_theme='purify'
let g:airline_theme='bubblegum'

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nmap <C-p>j <Plug>VimwikiNextLink
nmap <C-n>k <Plug>VimwikiPrevLink

nmap <C-j> :cn<CR>
nmap <C-k> :cp<CR>

"custom icons for ale
let g:ale_sign_error = '✖'
let g:ale_sign_warning = "⚠"

highlight ALEError cterm=underline ctermfg=196 gui=underline guifg=#FF875F
highlight ALEErrorSign ctermbg=NONE ctermfg=196
highlight ALEWarning cterm=underline gui=underline ctermfg=208 guifg=#fed8b1
highlight ALEWarningSign ctermbg=NONE ctermfg=208
let g:ale_linters = {'php': ['php', 'langserver', 'phan']}

"sync syntax (might slow down large files)
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

"coc
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:browser_search_default_engine = 'duckduckgo' 

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" ============="
" ==CustomCmds="
" ============="

command! -nargs=* Blame call s:GitBlame()
function! s:GitBlame()
    let cmd = "git blame -w " . bufname("%")
    let nline = line(".") + 1
    botright new
    execute "$read !" . cmd
    execute "normal " . nline . "gg"
    execute "set filetype=perl" 
endfunction

"Absolute path of open file to clipboard
function! Cwf()
    let @+=expand('%:p')
endfunction
command! Cwf call Cwf()

"ex) :Tag h1
function! Tag(name)
    let @"="<" . a:name . "></" . a:name . ">"
    normal! pbbl
    startinsert
endfunction
command! -nargs=1 Tag call Tag(<f-args>)

"ex) :Jtag HelloWorld
function! Jtag(name)
    let @"="<" . a:name . " />"
    normal! pb
    startinsert
endfunction
command! -nargs=1 Jtag call Jtag(<f-args>)

highlight Search ctermfg=white
highlight Search ctermbg=212

" Damian Conway's Die Blinkënmatchen: highlight matches
nnoremap <silent> n n:call HLNext(0.1)<cr>
nnoremap <silent> N N:call HLNext(0.1)<cr>

function! HLNext (blinktime)
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 500) . 'm'
  call matchdelete(ring)
  redraw
endfunction
