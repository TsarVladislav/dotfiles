""вообще не трогай, а то цвета работать не будут
set nocompatible
set re=1
set t_Co=256

colorscheme  gruvbox
set bg=dark

set number
set ttyfast
set cindent
set autoindent
set copyindent
set nobackup
set hidden
set noexpandtab
set noswapfile
set lazyredraw
set list
set noshowmode
set tabstop=4
set shiftwidth=4
set so=999
set laststatus=2
set clipboard=unnamedplus

syntax enable

"  выделять текущую строку
set cursorline

" показывать пары для [], {} и ()
set showmatch

" выделяет красным цветом символы, вылезающие за границу 80 символов
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
set colorcolumn=80
set listchars=eol:←,tab:→-,trail:•,extends:>,precedes:<

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'vim-syntastic/syntastic'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ludovicchabant/vim-gutentags'
Plug 'rhysd/vim-clang-format'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'skywind3000/gutentags_plus'
"Plug 'skywind3000/vim-preview'
"Plug 'Valloric/YouCompleteMe'
"Plug 'rdnetto/YCM-Generator'
Plug 'jiangmiao/auto-pairs'
" https://github.com/rizsotto/Bear#build-commands
Plug 'rizsotto/Bear'
Plug 'maralla/completor.vim'
augroup load_ycm
  autocmd!
    autocmd! InsertEnter *
            \ call plug#load('YouCompleteMe')     |
            \ if exists('g:loaded_youcompleteme') |
            \   call youcompleteme#Enable()       |
            \ endif                               |
            \ autocmd! load_ycm
augroup END
call plug#end()

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
filetype plugin on

setlocal foldmethod=marker
setlocal foldmarker={,}

" ----- статусбар ----- "
let g:airline_detect_paste=1
let g:airline_theme='minimalist'
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%{fugitive#statusline()}

" ----- проверка синтаксиса ----- "
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_cpp_checkers = [ 'gcc']
"let g:syntastic_cpp_compiler_options = '-std=c++11'
"let g:syntastic_cpp_check_header = 1

" ----- автодополнение ----- "
set completeopt +=menuone
set completeopt +=preview
let g:completor_clang_binary = '/usr/bin/clang'
let g:completor_auto_close_doc = 0
map <tab> <Plug>CompletorCppJumpToPlaceholder
imap <tab> <Plug>CompletorCppJumpToPlaceholder

"" превью снизу, а не сверху
augroup PreviewOnBottom
autocmd InsertEnter * set splitbelow
autocmd InsertLeave * set splitbelow!
augroup END

" ----- Syntastic ----- "

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>

" ----- Gutentags ----- "
let g:gutentags_ctags_executable = "ctags"
let g:gutentags_ctags_extra_args = ["-R --languages=C --exclude=.git --c-kinds=+p --fields=+iaS --extras=+q . "]
let g:gutentags_generate_on_write = 1
" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']
"let g:gutentags_trace = 1
" config project root markers.
let g:gutentags_project_root = ['.root']
" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" forbid gutentags adding gtags databases
let g:gutentags_auto_add_gtags_cscope = 1
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" ----- Clang Format ----- "
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
			\ "IndentWidth": 8,
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Linux"}

" ----- кодировка файла ----- "
"autocmd FileType c ClangFormatAutoEnable
" https://toster.ru/q/2061
if &fileencodings !~? "ucs-bom"
	set fileencodings^=ucs-bom
endif
if &fileencodings !~? "utf-8"
	let g:added_fenc_utf8 = 1
	set fileencodings+=utf-8
endif
if &fileencodings !~? "default"
	set fileencodins+=default
endif

set fileencodings=utf-8,cp1251,koi8-r,cp866
menu Encoding.koi8-r :e ++enc=koi8-r ++ff=unix<CR>
menu Encoding.windows-1251 :e ++enc=cp1251 ++ff=dos<CR>
menu Encoding.cp866 :e ++enc=cp866 ++ff=dos<CR>
menu Encoding.utf-8 :e ++enc=utf8<CR>
menu Encoding.koi8-u :e ++enc=koi8-u ++ff=unix<CR>


" ----- undo-tree ----- "
if has("persistent_sudo")
	set undodir=~/.undodir/
	set undofile
endif

" ----- хоткеи ----- "
map <F8> :emenu Encoding.
nmap <F1> <nop>
nnoremap <F1> :UndotreeToggle<cr>
nnoremap <F2> :pclose <cr>

" перемещение по вкладкам
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>


map <C-n> :NERDTreeToggle<CR>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:ycm_show_diagnostics_ui = 0

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" " better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


let g:NERDTreeWinSize=60
