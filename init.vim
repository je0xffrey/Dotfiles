" ============== "
" ====Basics==== "
" ============== "
syntax on
set background=dark
set t_Co=256
set nu

" Tabs
set et sw=4 ts=4 sts=4 " Default
autocmd FileType html :setlocal sw=2 ts=2 sts=2
autocmd FileType xml :setlocal sw=2 ts=2 sts=2

" Make vertical separator pretty
highlight VertSplit cterm=NONE
set fillchars+=vert:\▏

"ignoring .gitignore + folders
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" ============== "
" ===Mappings=== "
" ============== "
let mapleader=","

" Open up git blame in vsplit
nnoremap <leader>gb :Blame

" Move visual selection
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

"navigate buf with [tab] and bp with [shift+tab]
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" shift + k opens up documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" ============="
" ===Plugins==="
" ============="
let g:ale_disable_lsp = 1
call plug#begin('~/.local/share/nvim/plugged')

Plug 'pangloss/vim-javascript'    
Plug 'peitalin/vim-jsx-typescript'
Plug 'herringtondarkholme/yats.vim'
Plug 'gko/vim-coloresque'
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'

let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank','coc-prettier']
call plug#end()

" ============="
" PluginConfigs"
" ============="
colorscheme purify
let g:airline_theme='purify'

"custom icons for ale
let g:ale_sign_error = '✖'
let g:ale_sign_warning = "⚠"

highlight ALEError cterm=underline ctermfg=209 gui=underline guifg=#FF875F
highlight ALEErrorSign ctermbg=NONE ctermfg=209
highlight ALEWarning cterm=underline gui=underline ctermfg=228 guifg=#FFFF87
highlight ALEWarningSign ctermbg=NONE ctermfg=228

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
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
