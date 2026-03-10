set encoding=utf-8
filetype plugin indent on
syntax enable

" ========================================
" 表示
" ========================================
syntax on
set title
set showmatch
set expandtab
set shiftwidth=2
set tabstop=2
set autoindent
set number
set smartindent
set clipboard=unnamedplus,autoselect,unnamed
set display=lastline
set cc=81

" ========================================
" 検索
" ========================================
set ignorecase
set smartcase
set wrapscan

" ========================================
" その他
" ========================================
inoremap jj <ESC>
set history=5000
set visualbell t_vb=
set noerrorbells
set nobackup
set noswapfile
set autoread
set cursorline
set backspace=indent,eol,start
autocmd QuickFixCmdPost *grep* cwindow
autocmd BufWritePre * :call RTrim()
set hlsearch
nnoremap <F3> :set hlsearch!<CR>

function! RTrim()
  let s:cursor = getpos(".")
  if &filetype == "markdown"
    %s/\s\+\(\s\{2}\)$/\1/e
    match Underlined /\s\{2}/
  else
    %s/\s\+$//e
  endif
  call setpos(".", s:cursor)
endfunction

" ========================================
" 画面分割
" ========================================
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
