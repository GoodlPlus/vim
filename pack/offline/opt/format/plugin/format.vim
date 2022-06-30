vim9script
import autoload '../autoload/format.vim'
nnoremap <Leader>= <ScriptCmd>format.ClangFormat()<CR>
vnoremap <Leader>= <ScriptCmd>format.ClangFormat()<CR>
# nnoremap <Leader>= <ScriptCmd>format.BlackFormat()<CR>
# vnoremap <Leader>= <ScriptCmd>format.BlackFormat()<CR>
