let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox

let g:python_recommended_style = 0
let g:python_highlight_all = 1
let g:python_slow_sync = 0

let s:bg_0 = synIDattr(hlID('GruvboxBg0'), 'fg', 'gui')
let s:bg_1 = synIDattr(hlID('GruvboxBg1'), 'fg', 'gui')
let s:bg_2 = synIDattr(hlID('GruvboxBg2'), 'fg', 'gui')
let s:bg_3 = synIDattr(hlID('GruvboxBg3'), 'fg', 'gui')
let s:bg_4 = synIDattr(hlID('GruvboxBg4'), 'fg', 'gui')
let s:fg_0 = synIDattr(hlID('GruvboxFg0'), 'fg', 'gui')
let s:fg_1 = synIDattr(hlID('GruvboxFg1'), 'fg', 'gui')
let s:fg_2 = synIDattr(hlID('GruvboxFg2'), 'fg', 'gui')
let s:fg_3 = synIDattr(hlID('GruvboxFg3'), 'fg', 'gui')
let s:fg_4 = synIDattr(hlID('GruvboxFg4'), 'fg', 'gui')

let g:fileformat_icon =
\ {
	\ 'unix': '',
	\ 'dos': '',
	\ 'mac': '',
\ }

let g:default_file_icon = ''

let g:default_folder_icon = ''

let g:file_icon =
\ {
	\ 'L'          : '', 'erl'       : '', 'ksh'     : '',  'rbw'         : '',
	\ 'Rmd'        : '', 'es'        : '', 'less'    : '',  'rej'         : '',
	\ 'Smd'        : '', 'ex'        : '', 'lhs'     : '',  'rlib'        : '',
	\ 'ai'         : '', 'exs'       : '', 'lisp'    : '',  'rmd'         : '',
	\ 'awk'        : '', 'f#'        : '', 'lock'    : '',  'rmeta'       : '',
	\ 'bash'       : '', 'fish'      : '', 'log'     : '',  'rs'          : '',
	\ 'bat'        : '', 'fs'        : '', 'lsp'     : '',  'rss'         : '',
	\ 'bin'        : '', 'fsi'       : '', 'lua'     : '',  'sass'        : '',
	\ 'bmp'        : '', 'fsscript'  : '', 'markdown': '',  'scala'       : '',
	\ 'c'          : '', 'fsx'       : '', 'md'      : '',  'scss'        : '',
	\ 'c++'        : '', 'ft'        : '', 'mdown'   : '',  'sh'          : '',
	\ 'cc'         : '', 'fth'       : '', 'mdwn'    : '',  'slim'        : '',
	\ 'chs'        : '', 'gif'       : '', 'mjs'     : '',  'sln'         : '',
	\ 'cl'         : '', 'go'        : '', 'mkd'     : '',  'smd'         : '',
	\ 'clj'        : '', 'gz'        : '', 'mkdn'    : '',  'so'          : '',
	\ 'cljc'       : '', 'h'         : '', 'ml'      : 'λ',  'sql'         : '',
	\ 'cljs'       : '', 'h32'       : '', 'mli'     : 'λ',  'styl'        : '',
	\ 'cljx'       : '', 'hbs'       : '', 'mll'     : 'λ',  'suo'         : '',
	\ 'coffee'     : '', 'hex'       : '', 'mly'     : 'λ',  'swift'       : '',
	\ 'conf'       : '', 'hh'        : '', 'msql'    : '',  'sys'         : '',
	\ 'cp'         : '', 'hpp'       : '', 'mustache': '',  't'           : '',
	\ 'cpp'        : '', 'hrl'       : '', 'mysql'   : '',  'timestamp'   : '﨟',
	\ 'cs'         : '', 'hs'        : '', 'php'     : '',  'toml'        : '',
	\ 'csh'        : '', 'hs-boot'   : '', 'phtml'   : '',  'ts'          : '',
	\ 'csproj'     : '', 'htm'       : '', 'pl'      : '',  'tsx'         : '',
	\ 'csproj.user': '', 'html'      : '', 'plist'   : '况', 'twig'        : '',
	\ 'css'        : '', 'hxx'       : '', 'pm'      : '',  'txt'         : '',
	\ 'ctp'        : '', 'icn'       : '', 'png'     : '',  'ui'          : '',
	\ 'cxx'        : '', 'ico'       : '', 'pp'      : '',  'vim'         : '',
	\ 'd'          : '', 'ini'       : '', 'ps1'     : '',  'vue'         : '﵂',
	\ 'dart'       : '', 'jav'       : '', 'psb'     : '',  'wpl'         : '',
	\ 'db'         : '', 'java'      : '', 'psd'     : '',  'wsdl'        : '',
	\ 'diff'       : '', 'javascript': '', 'ptl'     : '',  'xcplayground': '',
	\ 'dump'       : '', 'jl'        : '', 'py'      : '',  'xht'         : '',
	\ 'dylib'      : '', 'jpeg'      : '', 'pyc'     : '',  'xhtml'       : '',
	\ 'edn'        : '', 'jpg'       : '', 'pyd'     : '',  'xlf'         : '',
	\ 'eex'        : '', 'js'        : '', 'pyi'     : '',  'xliff'       : '',
	\ 'ejs'        : '', 'json'      : '', 'pyo'     : '',  'xmi'         : '',
	\ 'el'         : '', 'jsonp'     : '', 'pyw'     : '',  'xml'         : '',
	\ 'elm'        : '', 'jsx'       : '', 'rb'      : '',  'xul'         : '',
	\ 'yaml'       : '', 'yaws'      : '', 'yml'     : '',  'zip'         : '',
	\ 'zsh'        : '',
\ }

let g:file_palette =
\ {
	\ '_':            {'guifg': 'NONE',  },
	\ 'default':      {'guifg': '#d8e698'},
	\ '.gvimrc':      {'guifg': '#00cc00'},
	\ '.vimrc':       {'guifg': '#00cc00'},
	\ '_gvimrc':      {'guifg': '#00cc00'},
	\ '_vimrc':       {'guifg': '#00cc00'},
	\ 'ai':           {'guifg': '#F37021'},
	\ 'awk':          {'guifg': '#d9b400'},
	\ 'bash':         {'guifg': '#d9b400'},
	\ 'bat':          {'guifg': '#bedcdc'},
	\ 'bmp':          {'guifg': '#2dcc9f'},
	\ 'c':            {'guifg': '#44cef6'},
	\ 'c++':          {'guifg': '#87d37c'},
	\ 'cc':           {'guifg': '#87d37c'},
	\ 'chs':          {'guifg': '#b87bb4'},
	\ 'cl':           {'guifg': '#aa79c1'},
	\ 'clj':          {'guifg': '#63b132'},
	\ 'cljc':         {'guifg': '#9cd775'},
	\ 'cljs':         {'guifg': '#9cd775'},
	\ 'cljx':         {'guifg': '#9cd775'},
	\ 'coffee':       {'guifg': '#bc9372'},
	\ 'conf':         {'guifg': '#99b8c4'},
	\ 'cp':           {'guifg': '#87d37c'},
	\ 'cpp':          {'guifg': '#87d37c'},
	\ 'cs':           {'guifg': '#57c153'},
	\ 'csh':          {'guifg': '#d9b400'},
	\ 'css':          {'guifg': '#3199e9'},
	\ 'cxx':          {'guifg': '#87d37c'},
	\ 'd':            {'guifg': '#b03931'},
	\ 'dart':         {'guifg': '#66c3fa'},
	\ 'db':           {'guifg': '#c4c7ce'},
	\ 'diff':         {'guifg': '#dd4c35'},
	\ 'dump':         {'guifg': '#c4c7ce'},
	\ 'edn':          {'guifg': '#63b132'},
	\ 'eex':          {'guifg': '#957aa5'},
	\ 'ejs':          {'guifg': '#bed27b'},
	\ 'el':           {'guifg': '#aa79c1'},
	\ 'elm':          {'guifg': '#5fb4cb'},
	\ 'erl':          {'guifg': '#eb0057'},
	\ 'es':           {'guifg': '#f5de19'},
	\ 'ex':           {'guifg': '#957aa5'},
	\ 'exs':          {'guifg': '#957aa5'},
	\ 'f#':           {'guifg': '#71b1d6'},
	\ 'fish':         {'guifg': '#d9b400'},
	\ 'fs':           {'guifg': '#71b1d6'},
	\ 'fsi':          {'guifg': '#71b1d6'},
	\ 'fsscript':     {'guifg': '#71b1d6'},
	\ 'fsx':          {'guifg': '#71b1d6'},
	\ 'gif':          {'guifg': '#2dcc9f'},
	\ 'go':           {'guifg': '#00acd7'},
	\ 'gvimrc':       {'guifg': '#00cc00'},
	\ 'h':            {'guifg': '#87d37c'},
	\ 'hbs':          {'guifg': 'NONE',  },
	\ 'hh':           {'guifg': '#87d37c'},
	\ 'hpp':          {'guifg': '#87d37c'},
	\ 'hrl':          {'guifg': '#eb0057'},
	\ 'hs':           {'guifg': '#b87bb4'},
	\ 'hs-boot':      {'guifg': '#b87bb4'},
	\ 'htm':          {'guifg': '#f1662a'},
	\ 'html':         {'guifg': '#f1662a'},
	\ 'hxx':          {'guifg': '#87d37c'},
	\ 'ico':          {'guifg': '#2dcc9f'},
	\ 'ini':          {'guifg': '#99b8c4'},
	\ 'java':         {'guifg': '#abc3ee'},
	\ 'javascript':   {'guifg': '#f5de19'},
	\ 'jl':           {'guifg': '#aa79c1'},
	\ 'jpeg':         {'guifg': '#2dcc9f'},
	\ 'jpg':          {'guifg': '#2dcc9f'},
	\ 'js':           {'guifg': '#f5de19'},
	\ 'json':         {'guifg': '#f5de19'},
	\ 'jsx':          {'guifg': '#00d8ff'},
	\ 'ksh':          {'guifg': '#d9b400'},
	\ 'leex':         {'guifg': '#957aa5'},
	\ 'less':         {'guifg': '#779dd6'},
	\ 'lhs':          {'guifg': '#b87bb4'},
	\ 'lua':          {'guifg': '#658ace'},
	\ 'markdown':     {'guifg': '#b48d60'},
	\ 'md':           {'guifg': '#b48d60'},
	\ 'mdx':          {'guifg': '#b48d60'},
	\ 'mjs':          {'guifg': '#f5de19'},
	\ 'ml':           {'guifg': '#cfcfcf'},
	\ 'mli':          {'guifg': '#cfcfcf'},
	\ 'mustache':     {'guifg': 'NONE',  },
	\ 'php':          {'guifg': '#859cc7'},
	\ 'pl':           {'guifg': '#00acd7'},
	\ 'pm':           {'guifg': '#00acd7'},
	\ 'png':          {'guifg': '#2dcc9f'},
	\ 'pp':           {'guifg': 'NONE',  },
	\ 'ps1':          {'guifg': '#af4343'},
	\ 'psb':          {'guifg': '#26C9FF'},
	\ 'psd':          {'guifg': '#26C9FF'},
	\ 'py':           {'guifg': '#5790c3'},
	\ 'pyc':          {'guifg': '#5790c3'},
	\ 'pyd':          {'guifg': '#5790c3'},
	\ 'pyi':          {'guifg': '#5790c3'},
	\ 'pyo':          {'guifg': '#5790c3'},
	\ 'pyw':          {'guifg': '#5790c3'},
	\ 'rb':           {'guifg': '#e52002'},
	\ 'rbw':          {'guifg': '#e52002'},
	\ 'rlib':         {'guifg': '#bbb5b0'},
	\ 'rmd':          {'guifg': '#b48d60'},
	\ 'rs':           {'guifg': '#bbb5b0'},
	\ 'rss':          {'guifg': '#00acd7'},
	\ 'sass':         {'guifg': '#d287da'},
	\ 'scala':        {'guifg': '#7ce1ff'},
	\ 'scss':         {'guifg': '#d287da'},
	\ 'sh':           {'guifg': '#d9b400'},
	\ 'slim':         {'guifg': '#a0c875'},
	\ 'sln':          {'guifg': '#0078cc'},
	\ 'sql':          {'guifg': '#c4c7ce'},
	\ 'styl':         {'guifg': '#3199e9'},
	\ 'suo':          {'guifg': '#0078cc'},
	\ 'swift':        {'guifg': '#f88535'},
	\ 't':            {'guifg': 'NONE',  },
	\ 'toml':         {'guifg': '#9b9898'},
	\ 'ts':           {'guifg': '#33aaff'},
	\ 'tsx':          {'guifg': '#00d8ff'},
	\ 'twig':         {'guifg': '#63bf6a'},
	\ 'vim':          {'guifg': '#00cc00'},
	\ 'vimrc':        {'guifg': '#00cc00'},
	\ 'vue':          {'guifg': '#41b883'},
	\ 'webp':         {'guifg': '#2dcc9f'},
	\ 'xcplayground': {'guifg': '#f88535'},
	\ 'xul':          {'guifg': '#f1662a'},
	\ 'yaml':         {'guifg': '#ffe885'},
	\ 'yml':          {'guifg': '#ffe885'},
	\ 'zsh':          {'guifg': '#d9b400'},
\ }

function s:get_highlight_palette(file_type, status) abort
	if empty(a:file_type)
		let l:icon = g:default_file_icon
		let l:palette = g:file_palette['_']
	else
		let l:palette = get(g:file_palette, a:file_type, g:file_palette['_'])
	endif
	let l:highlight_group = join(['palette', a:file_type, a:status], '_')
	if !highlight_exists(l:highlight_group)
		execute printf('highlight %s guifg=%s guibg=%s', l:highlight_group, l:palette['guifg'], a:status ==# 'active' ? s:bg_1 : s:bg_0)
	endif
	return '%#'.l:highlight_group.'#'
endfunction

function GetFileType(buffer_id) abort
	let l:file_extension = fnamemodify(bufname(a:buffer_id), ':e')
	if !empty(l:file_extension) && has_key(g:file_icon, l:file_extension)
		return l:file_extension
	else
		return getbufvar(a:buffer_id, '&filetype')
	endif
endfunction

function GetFileIcon(file_type) abort
	return get(g:file_icon, a:file_type, g:default_file_icon)
endfunction

let s:highlight_config =
\ {
	\ 'GruvboxRedSign': 	[{'NONE': 0}, {'guibg': 'NONE'}],
	\ 'GruvboxGreenSign': 	[{'NONE': 0}, {'guibg': 'NONE'}],
	\ 'GruvboxYellowSign': 	[{'NONE': 0}, {'guibg': 'NONE'}],
	\ 'GruvboxBlueSign': 	[{'NONE': 0}, {'guibg': 'NONE'}],
	\ 'GruvboxPurpleSign': 	[{'NONE': 0}, {'guibg': 'NONE'}],
	\ 'GruvboxAquaSign': 	[{'NONE': 0}, {'guibg': 'NONE'}],
	\ 'GruvboxOrangeSign': 	[{'NONE': 0}, {'guibg': 'NONE'}],
	\
	\ 'StatusLine': 		[{'NONE': 1}, {'guifg': s:fg_1, 'guibg': s:bg_1}],
	\ 'StatusLineNC': 		[{'NONE': 1}, {'guifg': s:fg_4, 'guibg': s:bg_0}],
	\
	\ 'TabLineSel': 		[{'NONE': 1}, {'guifg': s:fg_1, 'guibg': s:bg_1}],
	\ 'TabLine': 			[{'NONE': 1}, {'guifg': s:fg_4, 'guibg': s:bg_0}],
	\ 'TabLineFill': 		[{'NONE': 1}, {'guifg': s:fg_4, 'guibg': s:bg_0}],
	\
	\ 'LineNr': 			[{'NONE': 1}, {'guifg': s:fg_4}],
	\ 'CursorLineNr': 		[{'NONE': 0}, {'guibg': s:bg_0}],
	\
	\ 'SpellBad': 			[{'NONE': 1}, {'cterm': 'underline'}],
	\
	\ 'EndOfBuffer': 		[{'NONE': 1}, {'guifg': s:bg_0}],
	\
	\ 'Todo': 				[{'NONE': 1}, {'guifg': s:bg_0, 'guibg': s:fg_1}],
\ }
	""\ 'CursorLineNr': 		[{'NONE': 1}, {'guifg': s:fg_1, 'guibg': s:bg_0}],
	" \
	" \ 'Search': 			[{'NONE': 1}, {'guifg': s:bg_0, 'guibg': s:fg_1}],
	" \ 'IncSearch': 			[{'NONE': 1}, {'guifg': s:bg_0, 'guibg': s:fg_1}],

let s:statusline_config =
\ [
	\ '%#StatusLine#',
	\ '%{GetFileName()} ',
	\ '%{&readonly?" ":""}',
	\ '%{&modified?"+ ":""}',
	\ '%*',
	\
	\ '%#StatusLineNC#',
	\ '%=',
	\ '%*',
	\
	\ '%#StatusLine#',
	\ ' %p%%',
	\ ' %{(&fileencoding == "" ? &encoding : &fileencoding).(&bomb ? ",BOM" : "")}',
	\ ' %{g:fileformat_icon[&fileformat]} ',
	\ '%*',
\ ]

function GetFileName() abort
	let l:file_name = expand('%:~')
	if &filetype ==# 'leaderf' && &buftype ==# 'nofile'
		let l:file_name = matchstr(l:file_name, '\(\/usr\/share\/vim\/vim82\/\)\@<=.\+\(\/LeaderF\)\@=')
		let l:file_name .= ' ['.line('.').'/'.line('$').']'
	endif
	return l:file_name
endfunction

function s:set_highlight_group() abort
	for [l:highlight_group_name, l:highlight_group_arguments] in items(s:highlight_config)
		let l:command = 'highlight '.l:highlight_group_name.(get(l:highlight_group_arguments[0], 'NONE', 0) ? ' NONE' : '')
		for [l:argument_name, l:argument_value] in items(l:highlight_group_arguments[1])
			let l:command .= ' '.l:argument_name.'='.l:argument_value
		endfor
		execute l:command
	endfor
endfunction

function StatusLine(status) abort
	let l:file_type = GetFileType(bufnr('%'))
	let l:statusline = ''
	let l:statusline .= s:get_highlight_palette(l:file_type, a:status)
	let l:statusline .= ' '.GetFileIcon(l:file_type).' '
	let l:statusline .= '%*'
	for l:i in s:statusline_config
		let l:statusline .= l:i
	endfor
	return l:statusline
endfunction

function TabLine() abort
	let l:tabline = ''
	for l:i in range(1, bufnr('$'))
		if buflisted(l:i)
			let l:file_type = GetFileType(l:i)
			if l:i == bufnr('%')
				let l:highlight_default = '%#TabLineSel#'
				let l:highlight_icon = s:get_highlight_palette(l:file_type, 'active')
			else
				let l:highlight_default = '%#TabLine#'
" 				let l:highlight_icon = '%#TabLine#'
				let l:highlight_icon = s:get_highlight_palette(l:file_type, 'inactive')
			endif
			let l:tabline .= l:highlight_default
			let l:tabline .= getbufvar(l:i, '&modified') ? '+' : ' '
			let l:tabline .= '%*'

			let l:tabline .= l:highlight_icon
			let l:tabline .= GetFileIcon(l:file_type).' '
			let l:tabline .= '%*'

			let l:tabline .= l:highlight_default
			let l:tabline .= fnamemodify(bufname(l:i), ':t').' '
			let l:tabline .= '%*'
		endif
	endfor
	let l:tabline .= '%#TabLineFill#'
	let l:tabline .= '%='
	let l:tabline .= '%*'
	return l:tabline
endfunction

call <SID>set_highlight_group()
set tabline=%!TabLine()

augroup auto_update_statusline
	autocmd!
	autocmd BufEnter,WinEnter * call setbufvar('%', '&statusline', StatusLine('active'))
	autocmd WinLeave * call setbufvar('%', '&statusline', StatusLine('inactive'))
augroup END
