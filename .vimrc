""вообще не трогай, а то цвета работать не будут
set nocompatible
set re=1
set t_Co=256

if &term =~ '256color'
	set t_ut=
endif

colorscheme gruvbox
set background=dark

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
set wildmenu
set autochdir
set tags=tags;
set nogdefault
syntax enable

"  выделять текущую строку
set cursorline

" показывать пары для [], {} и ()
set showmatch

set colorcolumn=80
set listchars=eol:←,tab:→\ ,trail:•,extends:>,precedes:<

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ludovicchabant/vim-gutentags'
Plug 'rhysd/vim-clang-format'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'skywind3000/gutentags_plus'
Plug 'skywind3000/vim-preview'
Plug 'maralla/completor.vim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'miki725/vim-ripgrep'
call plug#end()

filetype plugin on

setlocal foldmethod=marker
setlocal foldmarker={,}

" ----- статусбар ----- "
let g:airline_detect_paste=1
let g:airline_theme='minimalist'
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%{fugitive#statusline()}

" ----- автодополнение ----- "
set completeopt +=menuone
set completeopt +=preview
let g:completor_clang_binary = '/usr/bin/clang'
let g:clighter_libclang_file = '/usr/lib/llvm-6.0/lib/libclang.so'
let g:completor_auto_close_doc = 0
map <tab> <Plug>CompletorCppJumpToPlaceholder
imap <tab> <Plug>CompletorCppJumpToPlaceholder

"" превью снизу, а не сверху
augroup PreviewOnBottom
autocmd InsertEnter * set splitbelow
autocmd InsertLeave * set splitbelow!
augroup END

" ----- Gutentags ----- "
let g:gutentags_ctags_executable = "ctags"
let g:gutentags_ctags_extra_args = ["-R --languages=C,C++ --exclude=.git --c-kinds=+p --fields=+iaS --extra=+q . "]
let g:gutentags_resolve_symlinks=1
let g:gutentags_generate_on_empty_buffer=0
let g:gutentags_generate_on_write=0
" enable gtags module
let g:gutentags_modules = ['ctags', 'cscope']
"let g:gutentags_trace = 1
" config project root markers.
let g:gutentags_project_root = ['.root']
" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" forbid gutentags adding gtags databases
let g:gutentags_auto_add_gtags_cscope = 1
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

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
nnoremap <F3> :PreviewTag <cr>
nnoremap <F4> :PreviewSignature! <cr>

" ----- перемещение по вкладкам ----- "
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" ----- netrw ----- "
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" ----- easyalign ----- "
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ----- UltSnips ----- "
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" ----- GitGutter ----- "
let g:gitgutter_max_signs = 3000
autocmd BufWritePost * GitGutter

" ----- FZF ----- "
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

" ----- ripgrep ----- "
" apt install ripgrep
" apt install cscope
" apt install ctags
"
