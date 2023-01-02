vim9script

import autoload '../autoload/format.vim'

nnoremap <Leader>= <ScriptCmd>format.Format()<CR>
xnoremap <Leader>= <ScriptCmd>format.Format()<CR>
