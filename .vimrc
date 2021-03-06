" PART 1
" ┌────────────────────────────────────────────────┐
" │                   atrributes                   │
" └────────────────────────────────────────────────┘
set shortmess=atI
colorscheme desert
set t_Co=256
" set the font
if has("gui_running")
	set lines=35 columns=140
" linux
  if has("gui_gtk2")
    set guifont=Anonymous\ Pro\ 14
" mac
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
" windows
  elseif has("win32") || has("win64")
    set guifont=Anonymous\ Pro:h14:cANSI
  endif
endif
" encoding
set fileencodings=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set encoding=utf-8
set linespace=3
set number
set cursorline
set ruler
set tabstop=4
set softtabstop=4
set shiftwidth=4
syntax on
set smartindent
set backspace=indent,eol,start
" CTRL-A could be use on alphabet
set nrformats=bin,octal,hex,alpha

" no auto comment leader when use o or O
au BufEnter * set fo-=o

highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

" fold
set foldmethod=syntax
set nofoldenable
" scroll
nnoremap <Up> <C-Y>k
nnoremap <Down> <C-E>j
set mouse=a
map <ScrollWheelUp> <C-Y>k
map <ScrollWheelDown> <C-E>j
" path
set path=.,/usr/include,,
set path+=/usr/include/c++/8.3.0
set path+=/usr/lib/gcc/x86_64-pc-linux-gnu/8.3.0/include/
set path+=/usr/include/gtk-3.0
" noshowmode need by plug echodoc and airline
set noshowmode
set incsearch
set showcmd
" autocomplete menu in Ex commands
set wildmenu
set wildmode=full

" PART 2
" ┌────────────────────────────────────────────────┐
" │                       map                      │
" └────────────────────────────────────────────────┘

" leader key
" --------------------------------------------------------------------------------
let mapleader = " "
" add ; to the end of the line
nnoremap <leader>; A;<ESC>
" go to tab left
nnoremap <leader>h gT
" go to tab right
nnoremap <leader>l gt
" jump to definition in new tab
nnoremap <silent><Leader>] <C-w><C-]><C-w>T
" go to next window
nnoremap <silent><Leader>w <C-w><C-w>
" call ToggleVirtualEdit in my scripts
nnoremap <leader>v :call ToggleVirtualEdit()<CR>
" call ToggleLineNumber in my scripts
nnoremap <leader>n :call ToggleLineNumber()<CR>
" call ToggleHighlightSearch in my scripts
nnoremap <leader>s :call ToggleHighlightSearch()<CR>

"  jump to header in new tab
" --------------------------------------------------------------------------------
nnoremap gf <C-W>gf

" :h open help in new tab
" --------------------------------------------------
cnoreabbrev <expr> h 
	\ getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'help'
" :E to edit file in new tab
" --------------------------------------------------
cnoreabbrev <expr> E getcmdtype() == ":" && getcmdline() == 'E' ? 'tabedit' : 'E'

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" PART 3
" ┌────────────────────────────────────────────────┐
" │                    vim-plugs                   │
" └────────────────────────────────────────────────┘
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" --------------------------------------------------
"  gcc to comment and uncomment, gc is an operator, also :Commentary
Plug 'tpope/vim-commentary'

" --------------------------------------------------
Plug 'ervandew/supertab'
" use ctrl-v + tab to insert a literal tab in insert mode

" Unmanaged plugin (manually installed and updated)
" --------------------------------------------------
" Plug 'Valloric/YouCompleteMe'
Plug '~/.vim/plugged/YouCompleteMe'

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
let g:ycm_filetype_whitelist = { 
			\ "c":1,
			\ "cpp":1, 
			\ "objc":1,
			\ "java":1,
			\ "python":1, 
			\ "sh":1,
			\ "zsh":1,
			\ "zimbu":1,
			\ }

" --------------------------------------------------
Plug 'SirVer/ultisnips'
let g:UltiSnipsEditSplit = "tabdo"
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnipsSnippets"
let g:UltiSnipsSnippetDirectories = ['UltiSnipsSnippets']
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<s-tab>"
let g:UltiSnipsJumpBackwardTrigger = "<c-tab>"

" --------------------------------------------------
Plug 'jiangmiao/auto-pairs', { 'for': ['c','cpp', 'java'] }

" --------------------------------------------------
"  :Move
Plug 'tpope/vim-eunuch'

" --------------------------------------------------
Plug 'ludovicchabant/vim-gutentags'
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
 let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
 let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0

" --------------------------------------------------
Plug 'Shougo/echodoc.vim'
let g:echodoc#enable_at_startup = 1

" --------------------------------------------------
Plug 'vim-airline/vim-airline'

" --------------------------------------------------
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='base16_monokai'

" --------------------------------------------------
Plug 'webdevel/tabulous'

" --------------------------------------------------
Plug 'https://github.com/luochen1990/rainbow'
let g:rainbow_active = 1
let g:rainbow_conf = {
 \ 'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
 \ 'ctermfgs': ['White', 'Cyan', 'Magenta', 'Green', 'Blue', 'Yellow', 'Red'],
 \ 'operators': '_,_',
 \ 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
 \ 'separately': {
 \  '*': {},
 \  'cpp': {
 \   'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/'],
 \  },
 \  'tex': {
 \   'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
 \  },
 \  'lisp': {
 \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
 \  },
 \  'vim': {
 \   'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
 \  },
 \  'html': {
 \   'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
 \  },
 \  'css': 0,
 \ }
 \}

" --------------------------------------------------
Plug 'octol/vim-cpp-enhanced-highlight'

" --------------------------------------------------
Plug 'skywind3000/asyncrun.vim'

" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <silent> <F10> :call asyncrun#quickfix_toggle(6)<cr>
nnoremap <leader>0 :call asyncrun#quickfix_toggle(6)<cr>
" 设置 F9  编译单文件
nnoremap <silent> <F9> :AsyncRun g++ -std=c++11 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <leader>9 :AsyncRun g++ -std=c++11 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" 设置 F5  运行
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <leader>5 :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 
" 设置 F7  编译整个项目
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
nnoremap <leader>7 :AsyncRun -cwd=<root> make <cr>
" 设置 F8  运行整个项目
nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
nnoremap <leader>8 :AsyncRun -cwd=<root> -raw make run <cr>
" 设置 F6  执行测试
nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>
nnoremap <leader>6 :AsyncRun -cwd=<root> -raw make test <cr>
" 设置 F4  更新Makefile文件
nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>
nnoremap <leader>4 :AsyncRun -cwd=<root> cmake . <cr>

" 延迟按需加载，使用到命令的时候再加载或者打开对应文件类型才加载
" --------------------------------------------------
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" F3 open the tree
map <F3> :NERDTreeToggle<CR>

" --------------------------------------------------
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

let g:easy_align_delimiters = {
\ '/': {
\     'pattern':         '//\+\|/\*\|\*/',
\     'delimiter_align': 'l',
\     'ignore_groups':   ['!Comment'] },
\ }

" --------------------------------------------------
Plug 'terryma/vim-multiple-cursors'

call plug#end()

" PART 4
" ┌────────────────────────────────────────────────┐
" │                   my scripts                   │
" └────────────────────────────────────────────────┘
function ToggleVirtualEdit ()
	if &ve ==# ""
		set ve=all
		echo "ToggleVirtualEdit [ all ]"
	elseif &ve ==# "all"
		set ve=
		echo "ToggleVirtualEdit [ default ]"
	endif
endfunction

function ToggleLineNumber ()
	if &number ==# "1"
		set nonumber
		echo "turn OFF line number"
	elseif &number ==# "0"
		set number
		echo "turn ON line number"
	endif
endfunction

function ToggleHighlightSearch ()
	if &hlsearch ==# "1"
		set nohlsearch
		echo "turn OFF highlight search"
	elseif &hlsearch ==# "0"
		set hlsearch
		echo "turn ON highlight search"
	endif
endfunction

