"dein Scripts-----------------------------

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_dir)
  execute '!git clone git@github.com:Shougo/dein.vim.git' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

if &compatible
  set nocompatible
endif

if dein#load_state(expand(s:dein_dir))
  " toms files
  let s:toml = '~/.dein.toml'
  let s:lazy_toml = '~/.dein_lazy.toml'

  call dein#begin(expand('~/.vim/dein'), [$MYVIMRC,s:toml])

  call dein#load_toml(s:toml)
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

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
set clipboard=unnamedplus,autoselect,unnamed " ヤンクした時にクリップボードに貼る
set display=lastline                         " 1行の文字数に関係なく文字列を表示する
set cc=81                                    " 81文字目に縦線を入れる "

" 検索
set ignorecase                               " 大文字/小文字の区別なく検索する
set smartcase                                " 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan                                 " 検索時に最後まで行ったら最初に戻る

" その他
inoremap  jj <ESC><ESC><ESC>
inoremap  kk <ESC><ESC><ESC>
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

" --------------------------------
" 画面分割
" --------------------------------
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

" --------------------------------
" Shougo/unite.vim
" --------------------------------
let g:unite_enable_start_insert=1

nmap <Space> [unite]

" プロジェクト内でバッファと最近開いたファイル一覧を表示
nnoremap <silent> [unite]f :<C-u>UniteWithProjectDir<Space>buffer file_mru<CR>

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag を使用
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}

" ファイル作成時にフォルダも作成する
augroup vimrc-auto-mkdir  " {{{
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'))
  function! s:auto_mkdir(dir)  " {{{
    if !isdirectory(a:dir)
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " }}}
augroup END  " }}}

" insert modeで開始
let g:unite_enable_start_insert = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')

" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" --------------------------------
" Shougo/vimfiler.vim
" --------------------------------
nnoremap <silent> <Space>vf  :VimFiler<CR>
let g:vimfiler_as_default_explorer = 1

" --------------------------------
" syntastic
" --------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntasticmodemap = { 'mode': 'active', 'active_filetypes': [
  \ 'ruby', 'javascript','coffee', 'scss', 'html', 'haml', 'slim', 'sh',
  \ 'spec', 'vim', 'zsh', 'sass', 'eruby'] }

let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_coffee_checkers = ['coffeelint']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_haml_checkers = ['haml_lint']
let g:syntastic_python_checkers = ["flake8"]

let g:syntastic_error_symbol='✗'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_ruby_rubocop_exe = 'bundle exec rubocop'

" -------------------------------
" soramugi/auto-ctags.vim
" -------------------------------
" let g:auto_ctags = 1
" let g:auto_ctags_directory_list = ['.git', '.svn']

" -------------------------------
" ctrlp.vim
" -------------------------------
let g:ctrlp_use_caching=0
let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'

" --------------------------------
" neocomplete.vim
" --------------------------------
let g:acp_enableAtStartup = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" --------------------------------
" vim-monster
" --------------------------------
" Set async completion.
let g:monster#completion#rcodetools#backend = "async_rct_complete"

" With neocomplete.vim
let g:neocomplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\}

" --------------------------------
" neosnippet.vim
" --------------------------------
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" --------------------------------
" vim-airline
" --------------------------------
set laststatus=2
let g:airline#extensions#syntastic#enabled = 1

" --------------------------------
" alvan/vim-closetag
" --------------------------------
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb"

" --------------------------------
" iberianpig/tig-explorer.vim
" --------------------------------
nnoremap <Space>t :TigOpenProjectRootDir<CR>

" --------------------------------
" vim-browsereload-mac
" --------------------------------
nnoremap <Space>r :ChromeReload<CR>

" --------------------------------
" mxw/vim-jsx
" --------------------------------
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" --------------------------------
" ruby-formatter/rufo-vim
" --------------------------------
" Enable rufo (RUby FOrmat)
let g:rufo_auto_formatting = 0

" --------------------------------
" tpope/vim-pathogen
" --------------------------------
execute pathogen#infect()

" --------------------------------
" sekel/vim-vue-syntastic
" --------------------------------
let g:syntastic_vue_checkers = ['eslint']
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
    let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
    let g:syntastic_javascript_eslint_exec = local_eslint
    let g:syntastic_vue_eslint_exec = local_eslint
endif

" --------------------------------
" Powerline
" --------------------------------
let g:powerline_pycmd="python3"
set rtp+=~/.pyenv/versions/3.7-dev/lib/python3.7/site-packages/powerline/bindings/vim
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup
set laststatus=2
set showtabline=2
set noshowmode

" --------------------------------
" FZF
" --------------------------------
" If installed using Homebrew
set rtp+=/usr/local/opt/fzf

" If installed using git
set rtp+=~/.fzf


" --------------------------------
" rm whitespace
" --------------------------------
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

" --------------------------------
" NERDTree
" --------------------------------
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" --------------------------------
" vim-node
" --------------------------------
autocmd User Node
  \ if &filetype == "javascript" |
  \   nmap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
  \   nmap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
  \ endif
