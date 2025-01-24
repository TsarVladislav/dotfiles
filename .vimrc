set nocompatible
"set re=1
set t_Co=256

" colors
set background=dark
set termguicolors
colorscheme gruvbox

set number            " show number of line
set autoread          " reload changed file
set copyindent        " copy the previous indentation on autoindenting
set nobackup          " do not keep backup files
set hidden
set noswapfile        " don't create swap files
set lazyredraw        " redraw not quite often
set list              " show symbols
set so=999
set laststatus=2
set clipboard=unnamedplus
set wildmenu
set autochdir
set nogdefault
set cursorline
set showmatch         " automatically highlight matching braces/brackets/etc.
set nofoldenable      " disable folds by default
set foldmethod=manual " tabs
set smartcase         " do case-sensitive if there's a capital letter
set switchbuf=newtab  " open in new tab
set colorcolumn=80,100
syntax on             " syntax higlight


" -----------------------------------------------------------------------------
" -------------------------- helping symbols ----------------------------------
" -----------------------------------------------------------------------------

set listchars=eol:←,tab:→\ ,trail:•,extends:>,precedes:<,space:␣

" -----------------------------------------------------------------------------
" ------------------------------ plugins --------------------------------------
" -----------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'      " align parts of code
Plug 'itchyny/lightline.vim'        " statusline

" snippets
Plug 'SirVer/ultisnips'

Plug 'tpope/vim-fugitive'           " git
Plug 'airblade/vim-gitgutter'       " show changed lines in vim
Plug 'morhetz/gruvbox'              " color scheme
Plug 'tpope/vim-vinegar'            " netrw

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'sheerun/vim-polyglot'         " color the code
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
call plug#end()

" -----------------------------------------------------------------------------
" -------------------------- autocomplete -------------------------------------
" -----------------------------------------------------------------------------
filetype plugin on

set completeopt +=menuone
set completeopt +=longest
set completeopt +=preview
" -----------------------------------------------------------------------------
" -------------------------- preview on the bottom ----------------------------
" -----------------------------------------------------------------------------

augroup PreviewOnBottom
autocmd InsertEnter * set splitbelow
autocmd InsertLeave * set splitbelow!
augroup END

" -----------------------------------------------------------------------------
" ------------------------------ hotkeys --------------------------------------
" -----------------------------------------------------------------------------

map <F2> :cclose <bar> lclose <bar> pclose<CR>
imap <F2> <Esc>:cclose <bar> lclose <bar> pclose<CR>i

" -----------------------------------------------------------------------------

autocmd Filetype python setlocal
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix

autocmd Filetype c setlocal
    \ tabstop=8
    \ softtabstop=8
    \ shiftwidth=8
    \ textwidth=79
    \ autoindent
    \ fileformat=unix
    \ cindent

" -----------------------------------------------------------------------------
" ------------------------------ lightline ------------------------------------
" -----------------------------------------------------------------------------

let g:lightline = {
    \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
\ }

vmap <C-c> "+y

" -----------------------------------------------------------------------------
" ------------------------------ netrw ----------------------------------------
" -----------------------------------------------------------------------------

let g:netrw_banner       = 0
let g:netrw_liststyle    = 3
let g:netrw_browse_split = 4
let g:netrw_altv         = 1
let g:netrw_winsize      = 25
let g:netrw_keepdir      = 0

" -----------------------------------------------------------------------------
" ------------------------------ easyalign ------------------------------------
" -----------------------------------------------------------------------------

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" -----------------------------------------------------------------------------
" ------------------------------ UltSnips -------------------------------------
" -----------------------------------------------------------------------------

let g:UltiSnipsExpandTrigger ="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" enable this plugin for filetypes, '*' for all files.
"let g:apc_enable_ft = {'*':1}

" source for dictionary, current or other loaded buffers, see ':help cpt'
"set cpt=.,k,w,b

" -----------------------------------------------------------------------------
" ------------------------------ Bat ------------------------------------------
" -----------------------------------------------------------------------------

augroup update_bat_theme
    autocmd!
    autocmd colorscheme * call ToggleBatEnvVar()
augroup end

" bat colors
function ToggleBatEnvVar()
    if (&background == "light")
        let $BAT_THEME='gruvbox-light'
    else
        let $BAT_THEME='gruvbox-dark'
    endif
endfunction

" -----------------------------------------------------------------------------
" ------------------------------- vim-session ---------------------------------
" -----------------------------------------------------------------------------

let g:session_autoload = 'no'
let g:session_autosave = 'no'

" -----------------------------------------------------------------------------
" ---------------------- omnicomplete on ctrl+space ---------------------------
" -----------------------------------------------------------------------------

inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" -----------------------------------------------------------------------------
" ------------------------------- LSP -----------------------------------------
" -----------------------------------------------------------------------------

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> K <plug>(lsp-hover)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_enabled=0
