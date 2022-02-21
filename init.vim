" ############## "
" ####Basics#### "
" ############## "

syntax on
set nocompatible
set smartcase
filetype plugin on
set background=dark
set nu
set guicursor=i:block
set cursorline
set confirm
set tabstop=4 shiftwidth=4 expandtab
autocmd BufRead,BufNewFile *.md setlocal textwidth=80 nonu
autocmd BufRead,BufNewFile  *.ts* setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile  *.js* setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile  *.*css setlocal ts=2 sw=2 expandtab
highlight VertSplit cterm=NONE
set fillchars+=vert:\▏


" ############## "
" ###Mappings### "
" ############## "

let mapleader="\<Space>"

" indent without losing the visual selection
xnoremap < <gv
xnoremap > >gv

nnoremap <leader>gb :Blame<CR>
nnoremap <leader>gy :Goyo<CR>
nnoremap <leader>q :bd<CR>
nnoremap <leader>aq :wqa<CR>

" insert space without leaving normal
nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D

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
"nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"jump to errors in llist
nnoremap <Leader>jj :call CocAction('diagnosticNext')<CR>
nnoremap <Leader>kk :call CocAction('diagnosticPrevious')<CR>

nnoremap <Leader>m :make<CR>

"shift + k opens up documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

"clear search highlighting until next search
nmap <Leader>/ :noh<CR>

"Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <silent> <Leader>s <Plug>SearchNormal
vmap <silent> <Leader>s <Plug>SearchVisual

"uppercase word after cursor in insert mode
imap <c-u> <esc>veU<esc>ea


" ############# "
" ###Plugins### "
" ############# "

let g:ale_disable_lsp = 1
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vimwiki/vimwiki'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
Plug 'NLKNguyen/papercolor-theme'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank']
call plug#end()

" ############### "
" #PluginConfigs# "
" ############### "

colorscheme PaperColor

let g:airline_theme='purify'
let g:airline_theme='bubblegum'

let g:vimwiki_folding = 'expr'

" set max width of Goyo 
let g:goyo_width = 90
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" disable git gutter in markdown files (laggy)
autocmd BufRead,BufNewFile  *.md GitGutterDisable | set nowrap 

nmap <C-p> :cn<CR>
nmap <C-n> :cp<CR>

nmap <C-j> <Plug>VimwikiNextLink
nmap <C-k> <Plug>VimwikiPrevLink

" all about git
nmap <leader>gn <Plug>(GitGutterNextHunk)
nmap <leader>gp <Plug>(GitGutterPrevHunk)
nmap <leader>ga <Plug>(GitGutterStageHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
nnoremap <leader>gs :Magit<CR>
nnoremap <leader>gP :! git push<CR>

"custom icons for ale
let g:ale_sign_error = '✖'
let g:ale_sign_warning = "⚠"

highlight ALEError cterm=underline ctermfg=196 gui=underline guifg=#FF875F
highlight ALEErrorSign ctermbg=NONE ctermfg=196
highlight ALEWarning cterm=underline gui=underline ctermfg=208 guifg=#fed8b1
highlight ALEWarningSign ctermbg=NONE ctermfg=208
let g:ale_linters = {'php': ['php', 'langserver', 'phan']}

"coc config
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
    
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" ############# " 
" ##Functions## "
" ############# "

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
function! Ptc()
    let @+=expand('%:p')
endfunction
command! Ptc call Ptc()

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

highlight Search ctermfg=39
highlight Search ctermbg=212
nnoremap <silent> n n:call HLNext(0.1)<cr>
nnoremap <silent> N N:call HLNext(0.1)<cr>

" Damian Conway's Die Blinkënmatchen: highlight matches
function! HLNext (blinktime)
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 500) . 'm'
  call matchdelete(ring)
  redraw
endfunction

" switch between last two buffers
nnoremap <leader><leader> <c-^>

" completes task and adds timestamp
nnoremap <leader>tt :call GetTOD()<CR>
function! GetTOD()
    "substitute removes extra escape character spawned by time-of-day
    let tod=substitute(system('time-of-day'), '\n$', '', '')
    " removes initial * [ ] on a to-do item
    let split_line=split(getline('.'), "] ")[1]
    " marks as complete and adds the timestamp and saved line
    call setline(line('.'), '* [X] ' . tod . ' ' . split_line)
endfunction

" create a new day for journal entry
nnoremap <leader>je :call JournalEntry()<CR>
function! JournalEntry()
    let entry=substitute(system('journal'), '\n$', '', '')
    call setline(line('.'), '#### ' . entry . ' ####')
endfunction
