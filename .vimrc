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
set ignorecase        " ignore case for searching
set smartcase         " do case-sensitive if there's a capital letter
set switchbuf=newtab  " open in new tab
set colorcolumn=80
set completeopt=menu,menuone,noselect " don't select the first item.
syntax on             " syntax higlight

set listchars=eol:←,tab:→\ ,trail:•,extends:>,precedes:<,space:␣

set completeopt +=menuone,
set completeopt +=longest
set completeopt +=preview

" preview on the bottom
augroup PreviewOnBottom
autocmd InsertEnter * set splitbelow
autocmd InsertLeave * set splitbelow!
augroup END

filetype plugin on

" hotkeys
nnoremap <F2> :cclose <bar> lclose <bar> pclose<CR>

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

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'      " align parts of code
Plug 'itchyny/lightline.vim'        " statusline

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'ludovicchabant/vim-gutentags' " ctags
Plug 'tpope/vim-fugitive'           " git
Plug 'airblade/vim-gitgutter'       " show changed lines in vim
Plug 'morhetz/gruvbox'              " color scheme
Plug 'tpope/vim-vinegar'            " netrw

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'sheerun/vim-polyglot'         " color the code
Plug 'skywind3000/gutentags_plus'   " cscope
call plug#end()

" statusbar
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

" netrw
let g:netrw_banner       = 0
let g:netrw_liststyle    = 3
let g:netrw_browse_split = 4
let g:netrw_altv         = 1
let g:netrw_winsize      = 25
let g:netrw_keepdir      = 0

" easyalign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" UltSnips
let g:UltiSnipsExpandTrigger ="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" enable this plugin for filetypes, '*' for all files.
let g:apc_enable_ft = {'*':1}

" source for dictionary, current or other loaded buffers, see ':help cpt'
set cpt=.,k,w,b

" Bat
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

" Gutentags

" see https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
let g:gutentags_enabled = 0
command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')

let g:gutentags_ctags_executable = "ctags"
let g:gutentags_modules = ['ctags', 'cscope']

let g:gutentags_ctags_extra_args = [
    \ '-R',
    \ '--c-kinds=+p',
    \ '--fields=+ailmnS',
    \ '--tag-relative=yes',
    \]

let g:gutentags_ctags_exclude = [
    \ '*.git', '*.svg', '*.hg',
    \ '*/tests/*',
    \ 'build',
    \ 'dist',
    \ '*sites/*/files/*',
    \ 'bin',
    \ 'node_modules',
    \ 'bower_components',
    \ 'cache',
    \ 'compiled',
    \ 'docs',
    \ 'example',
    \ 'bundle',
    \ 'vendor',
    \ '*.md',
    \ '*-lock.json',
    \ '*.lock',
    \ '*bundle*.js',
    \ '*build*.js',
    \ '.*rc*',
    \ '*.json',
    \ '*.min.*',
    \ '*.map',
    \ '*.bak',
    \ '*.zip',
    \ '*.pyc',
    \ '*.class',
    \ '*.sln',
    \ '*.Master',
    \ '*.csproj',
    \ '*.tmp',
    \ '*.csproj.user',
    \ '*.cache',
    \ '*.pdb',
    \ 'tags*',
    \ 'cscope.*',
    \ '*.css',
    \ '*.less',
    \ '*.scss',
    \ '*.exe', '*.dll',
    \ '*.mp3', '*.ogg', '*.flac',
    \ '*.swp', '*.swo',
    \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
    \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
    \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
    \ ]

let g:gutentags_define_advanced_commands  = 1
let g:gutentags_resolve_symlinks          = 1
let g:gutentags_generate_on_missing       = 1
let g:gutentags_generate_on_new           = 1
let g:gutentags_generate_on_empty_buffer  = 0
let g:gutentags_generate_on_write         = 0
let g:gutentags_modules                   = ['ctags', 'gtags_cscope']
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root              = ['.root', '.git']

let g:gutentags_cache_dir = expand('~/.cache/tags') " generate datebases in my cache directory

" forbid gutentags adding gtags databases
let g:gutentags_auto_add_gtags_cscope = 1
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
