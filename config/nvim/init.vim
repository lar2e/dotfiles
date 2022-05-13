" ========================================
" dein Scripts
" ========================================
if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
let s:lazy_toml = fnamemodify(expand('<sfile>'), ':h').'/dein_lazy.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:toml_file)
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

" ========================================
" Basic Settings
" ========================================
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
set encoding=utf-8
filetype plugin indent on
syntax enable

" 表示
syntax on                                    " コードの色分け
set title                                    " 編集中のファイル名を表示
set showmatch                                " 括弧入力時の対応する括弧を表示
set expandtab                                " タブ入力を複数の余白入力に置き換える
set shiftwidth=2                             " 自動インデントでずれる幅
set tabstop=2                                " インデントをスペース2つ分に設定
set autoindent                               " オートインデント
set number                                   " 行番号を表示
set smartindent                              " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set clipboard=unnamedplus,unnamed            " ヤンクした時にクリップボードに貼る
set display=lastline                         " 1行の文字数に関係なく文字列を表示する
set cc=81                                    " 81文字目に縦線を入れる "

" 検索
set ignorecase                               " 大文字/小文字の区別なく検索する
set smartcase                                " 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan                                 " 検索時に最後まで行ったら最初に戻る

" その他
inoremap  jj <ESC><ESC><ESC>
set history=5000                             " 検索履歴数をデフォルト(20件）から1000件にする
set visualbell t_vb=                         " ビープ音すべてを無効にする
set noerrorbells                             " エラーメッセージの表示時にビープを鳴らさない
set nobackup                                 " ファイル保存時にバックアップファイルを作らない
set noswapfile                               " ファイル編集中にスワップファイルを作らない
set autoread                                 " 外部でファイルに変更がされた場合は読みなおす
set cursorline                               " カーソル行の背景色変更
set backspace=indent,eol,start               " backspaceで消せるようにする
autocmd QuickFixCmdPost *grep* cwindow       " grep後にquickfix-windowを起動する
autocmd BufWritePre * :call RTrim()          " ファイル保存時に行末の空白を自動削除
set hlsearch!
nnoremap <F3> :set hlsearch!<CR>

augroup myfiletypes
  " Section: ruby
  autocmd BufRead,BufNewFile Capfile set ft=ruby
  autocmd BufRead,BufNewFile Gemfile set ft=ruby
  autocmd BufRead,BufNewFile *.god set ft=ruby
  autocmd BufRead,BufNewFile *.ru set ft=ruby
augroup END

" ========================================
" Split Windows
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
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

" ========================================
" change buffers
" ========================================
nnoremap <silent>bp :bprevious<CR>
nnoremap <silent>bn :bnext<CR>
nnoremap <silent>bb :b#<CR>

" ========================================
" remove whitespaces
" ========================================
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
