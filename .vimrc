set nocompatible
set re=1
set t_Co=256

set background=light
colorscheme PaperColor

" show number of line
set number

" reload changed file
set autoread

 " copy the previous indentation on autoindenting
set copyindent

" do not keep backup files
set nobackup

" ¯\_(ツ)_/¯
set hidden

" don't create swap files
set noswapfile

" redraw not quite often
set lazyredraw

" show symbols
set list

autocmd Filetype python setlocal
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix

autocmd Filetype c setlocal
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ autoindent
    \ fileformat=unix
    \ cindent

set so=999
set laststatus=2

set clipboard=unnamedplus
set wildmenu
set autochdir
set nogdefault
set cursorline

" automatically highlight matching braces/brackets/etc.
set showmatch

" disable folds by default
set nofoldenable

" ignore case for searching
set ignorecase

" do case-sensitive if there's a capital letter
set smartcase

" open in new tab
set switchbuf=newtab

" syntax higlight
syntax on

set colorcolumn=80
set listchars=eol:←,tab:→\ ,trail:•,extends:>,precedes:<,space:␣

call plug#begin('~/.vim/plugged')
" align parts of code
Plug 'junegunn/vim-easy-align'

" statusline
Plug 'itchyny/lightline.vim'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Ctags
Plug 'ludovicchabant/vim-gutentags'

" git
Plug 'tpope/vim-fugitive'

" show changed lines in vim
Plug 'airblade/vim-gitgutter'

" color scheme
Plug 'NLKNguyen/papercolor-theme'

" netrw
Plug 'tpope/vim-vinegar'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'sheerun/vim-polyglot'

call plug#end()

filetype plugin on

" tabs
set foldmethod=manual

" statusbar
let g:lightline = {
    \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
\ }

" autocomplete
set completeopt +=menuone
set completeopt +=longest
set completeopt +=preview

" preview on the bottom
augroup PreviewOnBottom
autocmd InsertEnter * set splitbelow
autocmd InsertLeave * set splitbelow!
augroup END

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
                        \ '--extra=+l . ',
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

let g:gutentags_define_advanced_commands = 1
let g:gutentags_resolve_symlinks=1
let g:gutentags_generate_on_missing=1
let g:gutentags_generate_on_new=1
let g:gutentags_generate_on_empty_buffer=0
let g:gutentags_generate_on_write=0
let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['.root', '.git']

" generate datebases in my cache directory
let g:gutentags_cache_dir = expand('~/.cache/tags')

" forbid gutentags adding gtags databases
let g:gutentags_auto_add_gtags_cscope = 1
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
vmap <C-c> "+y

" hotkeys
nnoremap <F2> :cclose <bar> lclose <bar> pclose<CR>

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" easyalign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" UltSnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" enable this plugin for filetypes, '*' for all files.
let g:apc_enable_ft = {'*':1}

" source for dictionary, current or other loaded buffers, see ':help cpt'
set cpt=.,k,w,b

" don't select the first item.
set completeopt=menu,menuone,noselect

" suppress annoy messages.
set shortmess+=c
