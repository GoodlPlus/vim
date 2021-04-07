" ------------------------------------------------------------------------------
" Resume last position
" ------------------------------------------------------------------------------
let s:vimview_name = 'vimview'
let s:vimview_path = fnameescape(join([g:_VIM_CACHE_PATH, s:vimview_name], '/'))
let s:vimview_max_files = 999
let s:vimview_offset = 3
let s:vimview_max_lines = s:vimview_max_files * s:vimview_offset - 1

function view#restore_view()
	let l:file_name = fnameescape(expand('%:~'))
	if empty(l:file_name)
		return
	endif
	let l:current_view = winsaveview()
	if l:current_view['lnum'] != 1 || l:current_view['col'] != 0
		return
	endif
	let l:lines = readfile(s:vimview_path, '', s:vimview_max_lines)
	let l:index = index(l:lines, l:file_name)
	if l:index == -1
		return
	endif
	let l:view_key = []
	for l:key in keys(l:current_view)
		call add(l:view_key, l:key)
	endfor
	let l:saved_view = {}
	let l:saved_view_value = split(l:lines[l:index + 1])
	let l:value_index = 0
	for l:key in l:view_key
		let l:saved_view[l:key] = l:saved_view_value[l:value_index]
		let l:value_index += 1
	endfor
	call winrestview(l:saved_view)
endfunction

function view#save_view()
	let l:file_name = fnameescape(expand('%:~'))
	if empty(l:file_name)
		return
	endif
	let l:lines = readfile(s:vimview_path, '', s:vimview_max_lines)
	if !empty(l:lines)
		call add(l:lines, '')
	endif
	let l:current_view = winsaveview()
	let l:view_value = []
	for l:value in values(l:current_view)
		call add(l:view_value, l:value)
	endfor
	let l:view_value = join(l:view_value)
	let l:index = index(l:lines, l:file_name)
	if l:index != -1
		unlet l:lines[l:index:l:index + s:vimview_offset - 1]
	endif
	call extend(l:lines, [l:file_name, l:view_value, ''], 0)
	unlet l:lines[-1]
	if len(l:lines) > s:vimview_max_lines
		unlet l:lines[s:vimview_max_lines:]
	endif
	call writefile(l:lines, s:vimview_path)
endfunction
