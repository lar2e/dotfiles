let g:neoterm_autoscroll = 1
" # let g:neoterm_split_on_tnew = 1
let g:neoterm_size = 10
let g:neoterm_default_mod = 'belowright'

nnoremap <silent> ,rc :TREPLSendFile<cr>
nnoremap <silent> ,rl :TREPLSendLine<cr>
cnoremap <silent> ,rl :TREPLSendSelection<cr>
nnoremap <silent> vt :vert Tnew<cr>
nnoremap <silent> st :belowright Tnew<cr>
nnoremap <silent> vs :terminal<cr>let g:neoterm_autoinsert = 1
nnoremap <silent> tt :belowright Tnew<CR>
