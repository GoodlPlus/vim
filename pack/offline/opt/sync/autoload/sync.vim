let s:debug_mode = 0

function sync#exit_cb(channel, message) abort
	let l:job_info = job_info(a:channel)
	let l:file_name = expand('%:~')
	for l:i in l:job_info['cmd']
		if l:i ==# 'rsync'
			let l:type = 'rsync'
		endif
	endfor
	let l:src_path = fnamemodify(l:job_info['cmd'][-2], ':~')
	let l:dst_path = split(l:job_info['cmd'][-1], ':')[-1]
	if l:job_info['exitval'] == 0
		if s:debug_mode
			echomsg join(['Successfully:', l:type, l:src_path, l:dst_path])
		else
			echo join(['Successfully:', l:type, l:src_path, l:dst_path])
		endif
	else
		echomsg join(['Failed:', l:type, l:src_path, l:dst_path])
	endif
	if s:debug_mode
		echomsg "exit_cb: " l:job_info
	endif
endfunction

function sync#out_cb(channel, message) abort
	if s:debug_mode
		echomsg "out_cb: ".a:message
	endif
endfunction

function sync#err_cb(channel, message) abort
	if s:debug_mode
		echomsg "err_cb: ".a:message
	endif
endfunction

let s:callback =
\ {
	\ 'mode': 'nl',
	\ 'exit_cb': function('sync#exit_cb'),
	\ 'out_cb': function('sync#out_cb'),
	\ 'err_cb': function('sync#err_cb'),
	\ 'stoponexit': '',
\ }

function sync#sync(mode)
	let l:file_name = fnameescape(expand('%:p'))
	let l:cmd = ''
	for l:sync_info in g:sync_list
		let l:escape_file_name = escape(l:file_name, '~.')
		let l:escape_local_path = escape(l:sync_info['local_path'], '~.')
		if l:escape_file_name =~# l:escape_local_path
			let l:executable_file = 'rsync'
			let l:args = []
			for [l:key, l:value] in items(l:sync_info['args'])
				let l:arg = l:key
				if !empty(l:value)
					let l:arg .= '='.l:value
				endif
				call add(l:args, l:arg)
			endfor
			let l:args = join(l:args)
			if a:mode =~# 'all'
				let l:local = l:sync_info['local_path']
				let l:remote = l:sync_info['remote_user'].'@'.l:sync_info['remote_host'].':'.l:sync_info['remote_path']
			else
				let l:tail_file_name = substitute(l:escape_file_name, l:escape_local_path, '', '')
				let l:tail_file_name = substitute(l:tail_file_name, '\\\~', '~', '')
				let l:tail_file_name = substitute(l:tail_file_name, '\\\.', '.', '')
				let l:local = l:file_name
				let l:remote = l:sync_info['remote_user'].'@'.l:sync_info['remote_host'].':'.l:sync_info['remote_path'].l:tail_file_name
			endif
			if a:mode =~# 'upload'
				let l:cmd = join([l:executable_file, l:args, l:local, l:remote])
			else
				let l:cmd = join([l:executable_file, l:args, l:remote, l:local])
			endif
			break
		endif
	endfor
	if empty(l:cmd)
		return
	endif
	call job_start(l:cmd, s:callback)
endfunction
