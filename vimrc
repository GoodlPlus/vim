if get(s:, 'loaded', 0)
	finish
else
	let s:loaded = 1
endif

set nocompatible

let g:loaded_getscriptPlugin = 1
let loaded_gzip = 1
let loaded_logiPat = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let loaded_rrhelper = 1
let loaded_spellfile_plugin = 1
let g:loaded_tarPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1

let g:home_path = fnameescape(expand('<sfile>:p:h'))
let s:init_name = fnameescape('init')
let s:init_path = fnameescape(join([g:home_path, s:init_name], '/'))
let s:init_list =
\ [
	\ 'basic',
	\ 'plugin',
	\ 'keymap',
	\ 'theme',
\ ]

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
