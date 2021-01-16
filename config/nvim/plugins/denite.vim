" Define mappings
" Deniteの設定
nnoremap [denite] <Nop>
nmap <C-u> [denite]

" -buffer-name=
nnoremap <silent> [denite]g :<C-u>Denite grep -buffer-name=search-buffer-denite<CR>
nnoremap <silent> [denite]<C-f> :<C-u>Denite file/rec<CR>

" Denite grep検索結果を再表示する
nnoremap <silent> [denite]r :<C-u>Denite -resume -buffer-name=search-buffer-denite<CR>
" resumeした検索結果の次の行の結果へ飛ぶ
nnoremap <silent> [denite]n :<C-u>Denite -resume -buffer-name=search-buffer-denite -select=+1 -immediately<CR>
" resumeした検索結果の前の行の結果へ飛ぶ
nnoremap <silent> [denite]p :<C-u>Denite -resume -buffer-name=search-buffer-denite -select=-1 -immediately<CR>
"現在開いているファイルのディレクトリ下のファイル一覧。
nnoremap <silent> [denite]f :<C-u>DeniteBufferDir -direction=topleft -cursor-wrap=true file file:new<CR>
"バッファ一覧
nnoremap <silent> [denite]b :<C-u>Denite -direction=topleft -cursor-wrap=true buffer<CR>
"レジスタ一覧
nnoremap <silent> [denite]r :<C-u>Denite -direction=topleft -cursor-wrap=true -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [denite]m :<C-u>Denite -direction=topleft -cursor-wrap=true file_mru<CR>
"ブックマーク一覧
nnoremap <silent> [denite]c :<C-u>Denite -direction=topleft -cursor-wrap=true bookmark<CR>
"ブックマークに追加
nnoremap <silent> [denite]a :<C-u>DeniteBookmarkAdd<CR>

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction

" Change file/rec command.
call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', '', '--ignore', 'node_modules'])
" For ripgrep
" Note: rg is faster than ag
" call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!{node_modules,.git}', '--color', 'never'])
" For Pt(the platinum searcher)
" NOTE: It also supports windows.
" call denite#custom#var('file/rec', 'command', ['pt', '--follow', '--nocolor', '--nogroup',  (has('win32') ? '-g:' : '-g='), ''])
" For python script scantree.py
" Read bellow on this file to learn more about scantree.py
" call denite#custom#var('file/rec', 'command', ['scantree.py', '--path', ':directory'])

" Change matchers.
call denite#custom#source('file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])
call denite#custom#source('file/rec', 'matchers', ['matcher/cpsm'])

" Change sorters.
call denite#custom#source('file/rec', 'sorters', ['sorter/sublime'])

" Change default action.
call denite#custom#kind('file', 'default_action', 'split')

" Add custom menus
let s:menus = {}

let s:menus.zsh = { 'description': 'Edit your import zsh configuration' }
let s:menus.zsh.file_candidates = [
	\ ['zshrc', '~/.config/zsh/.zshrc'],
	\ ['zshenv', '~/.zshenv'],
	\ ]

let s:menus.my_commands = {
	\ 'description': 'Example commands'
	\ }
let s:menus.my_commands.command_candidates = [
	\ ['Split the window', 'vnew'],
	\ ['Open zsh menu', 'Denite menu:zsh'],
	\ ['Format code', 'FormatCode', 'go,python'],
	\ ]

call denite#custom#var('menu', 'menus', s:menus)

" Ag command on grep source
call denite#custom#var('grep', {
	\ 'command': ['ag'],
	\ 'default_opts': ['-i', '--vimgrep'],
	\ 'recursive_opts': [],
	\ 'pattern_opt': [],
	\ 'separator': ['--'],
	\ 'final_opts': [],
	\ })

" Ack command on grep source
call denite#custom#var('grep', {
	\ 'command': ['ack'],
	\ 'default_opts': [
	\   '--ackrc', $HOME.'/.ackrc', '-H', '-i',
	\   '--nopager', '--nocolor', '--nogroup', '--column'
	\ ],
	\ 'recursive_opts': [],
	\ 'pattern_opt': ['--match'],
	\ 'separator': ['--'],
	\ 'final_opts': [],
	\ })

" Ripgrep command on grep source
call denite#custom#var('grep', {
	\ 'command': ['rg'],
	\ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
	\ 'recursive_opts': [],
	\ 'pattern_opt': ['--regexp'],
	\ 'separator': ['--'],
	\ 'final_opts': [],
	\ })

" Pt command on grep source
call denite#custom#var('grep', {
	\ 'command': ['pt'],
	\ 'default_opts': [
	\   '-i', '--nogroup', '--nocolor', '--smart-case'],
	\ 'recursive_opts': [],
	\ 'pattern_opt': [],
	\ 'separator': ['--'],
	\ 'final_opts': [],
	\ })

" jvgrep command on grep source
call denite#custom#var('grep', {
	\ 'command': ['jvgrep'],
	\ 'default_opts': ['-i'],
	\ 'recursive_opts': ['-R'],
	\ 'pattern_opt': [],
	\ 'separator': [],
	\ 'final_opts': [],
	\ })

" Specify multiple paths in grep source
"call denite#start([{'name': 'grep',
"      \ 'args': [['a.vim', 'b.vim'], '', 'pattern']}])

" Define alias
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#alias('source', 'file/rec/py', 'file/rec')
call denite#custom#var('file/rec/py', 'command',
\ ['scantree.py', '--path', ':directory'])

" Change ignore_globs
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/', 'node_modules'])

" Custom action
" Note: lambda function is not supported in Vim8.
call denite#custom#action('file', 'test',
      \ {context -> execute('let g:foo = 1')})
call denite#custom#action('file', 'test2',
      \ {context -> denite#do_action(
      \  context, 'open', context['targets'])})
" Source specific action
call denite#custom#action('source/file', 'test',
      \ {context -> execute('let g:bar = 1')})
