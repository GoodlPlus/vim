let g:engine = "DeepL"
" noremap <silent> <Leader>t :<C-u>Translate --id=<C-r>=g:id<CR> --key=<C-r>=g:key<CR><CR>
nnoremap <silent> <Leader>t :Translate n --engine=<C-r>=g:engine<CR><CR>
vnoremap <silent> <Leader>t :<C-u>Translate v --engine=<C-r>=g:engine<CR><CR>
