set shortmess=atI
"set lines=35 columns=100
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

" --------------------------------------------------------------------------------
" New line
" press <TAB/SHIFT+TAB> to add a new line without entering INSERT MODE
" and stay in the line where you have been before
" nmap <S-TAB> O<ESC>j
" nmap <TAB> o<ESC>k
" press <TAB/SHIFT+TAB> to add a new line without entering INSERT MODE
nmap <S-TAB> O<ESC>
nmap <TAB> o<ESC>
" --------------------------------------------------------------------------------

" --------------------------------------------------------------------------------
" Draw a line
" press <-> to add a minus directly, easy to draw a line with numbers
" e.g. 50- to input 50 minus to draw a line occupy 50 characters
nmap - a-<ESC>
" --------------------------------------------------------------------------------

" --------------------------------------------------------------------------------
" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
" --------------------------------------------------------------------------------
