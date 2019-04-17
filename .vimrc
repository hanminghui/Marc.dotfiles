set shortmess=atI
" set lines=35 columns=100
colorscheme desert
set t_Co=256
set guifont=Anonymous\ Pro\ 14
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

" New line
" --------------------------------------------------------------------------------
" press <TAB/SHIFT+TAB> to add a new line without entering INSERT MODE
" and stay in the line where you have been before
" nmap <S-TAB> O<ESC>j
" nmap <TAB> o<ESC>k
" press <TAB/SHIFT+TAB> to add a new line without entering INSERT MODE
" nmap <S-TAB> O<ESC>
" nmap <TAB> o<ESC>

" New space
" --------------------------------------------------------------------------------
" press SPACE to add a space
nmap <SPACE> a<SPACE><ESC>h

" Draw a line
" --------------------------------------------------------------------------------
" press <-> to add a minus directly, easy to draw a line with numbers
" e.g. 50- to input 50 minus to draw a line occupy 50 characters
nmap - a-<ESC>

" Commenting blocks of code.
" --------------------------------------------------------------------------------
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" --------------------------------------------------------------------------------
" vim-plug
" --------------------------------------------------------------------------------
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'ervandew/supertab'

" --------------------------------------------------
Plug 'Valloric/YouCompleteMe'
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
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" --------------------------------------------------
Plug 'Shougo/echodoc.vim'

" --------------------------------------------------
Plug 'vim-airline/vim-airline'
set noshowmode
" --------------------------------------------------
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='base16_grayscale'

" --------------------------------------------------
Plug 'octol/vim-cpp-enhanced-highlight'

" --------------------------------------------------
Plug 'skywind3000/asyncrun.vim'

" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <silent> ,0 :call asyncrun#quickfix_toggle(6)<cr>
" 设置 F9  编译单文件
nnoremap <silent> ,9 :AsyncRun g++ -std=c++11 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" 设置 F5  运行
nnoremap <silent> ,5 :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 
" 设置 F7  编译整个项目
nnoremap <silent> ,7 :AsyncRun -cwd=<root> make <cr>
" 设置 F8  运行整个项目
nnoremap <silent> ,8 :AsyncRun -cwd=<root> -raw make run <cr>
" 设置 F6  执行测试
nnoremap <silent> ,6 :AsyncRun -cwd=<root> -raw make test <cr>
" 设置 F4  更新Makefile文件
nnoremap <silent> ,4 :AsyncRun -cwd=<root> cmake . <cr>

call plug#end()

highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

