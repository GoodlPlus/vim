if exists('g:loaded')
    finish
else
    let g:loaded = 1
endif

let $LANG = "en"
set nocompatible

" let g:loaded_getscriptPlugin = 1
" let loaded_gzip = 1
" let loaded_logiPat = 1
" let g:loaded_netrw = 1
" let g:loaded_netrwPlugin = 1
" let loaded_rrhelper = 1
" let loaded_spellfile_plugin = 1
" let g:loaded_tarPlugin = 1
" let g:loaded_2html_plugin = 1
" let g:loaded_vimballPlugin = 1
" let g:loaded_zipPlugin = 1

const g:_VIM_PATH = fnameescape(expand('<sfile>:p:h'))
const g:_VIM_CACHE_PATH = fnameescape(join([g:_VIM_PATH, 'cache'], '/'))
if empty(glob(g:_VIM_CACHE_PATH))
    silent execute '!mkdir -p '.g:_VIM_CACHE_PATH
endif
let g:coc_data_home = join([g:_VIM_CACHE_PATH, 'coc'], '/')
let s:init_name = fnameescape('init')
let s:init_path = fnameescape(join([g:_VIM_PATH, s:init_name], '/'))
let s:init_list =
\ [
    \ 'basic',
\ ]
"   \ 'plugin',
"   \ 'keymap',
"   \ 'theme',

function SourceVim(path, name)
    let l:name = a:name.'.vim'
    let l:source_path = join([a:path, l:name], '/')
    let l:source_path = fnameescape(l:source_path)
    if !empty(glob(l:source_path))
        execute 'source '.l:source_path
    endif
endfunction

function s:init()
    for l:i in s:init_list
        call SourceVim(s:init_path, l:i)
    endfor
endfunction

call <SID>init()
