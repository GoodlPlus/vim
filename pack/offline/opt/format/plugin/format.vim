vim9script

import autoload '../autoload/format.vim'

nnoremap <Leader>= <ScriptCmd>format.Format()<CR>
vnoremap <Leader>= <ScriptCmd>format.Format()<CR>
