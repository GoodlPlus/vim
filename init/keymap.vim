" ------------------------------------------------------------------------------
" Personal alt keymaps
" ------------------------------------------------------------------------------
function s:set_key(key)
	execute "set <M-".a:key.">=\e".a:key
endfunction

function s:init_meta()
	for i in range(10)
		let l:key = nr2char(char2nr('0') + i)
		call <SID>set_key(l:key)
	endfor
	for i in range(26)
		let l:key = nr2char(char2nr('a') + i)
		call <SID>set_key(l:key)
		let l:key = nr2char(char2nr('A') + i)
		call <SID>set_key(l:key)
	endfor
	call <SID>set_key(',')
	call <SID>set_key('.')
endfunction

call <SID>init_meta()
delfunction <SID>set_key
delfunction <SID>init_meta


" ------------------------------------------------------------------------------
" Personal tab keymaps
" ------------------------------------------------------------------------------
" nnoremap <Tab>H <C-w>H
" nnoremap <Tab>J <C-w>J
" nnoremap <Tab>K <C-w>K
" nnoremap <Tab>L <C-w>L
"
" nnoremap <Tab>w <C-w>w
" nnoremap <Tab>c <C-w>c
"
" nnoremap <Tab>s <C-w>s
" nnoremap <Tab>v <C-w>v

nnoremap <M-,> <C-w><
nnoremap <M-.> <C-w>>

noremap <M-h> <C-w>h
noremap <M-j> <C-w>j
noremap <M-k> <C-w>k
noremap <M-l> <C-w>l

noremap <M-n> <Cmd>bnext<CR>
noremap <M-p> <Cmd>bprevious<CR>

tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l

tnoremap <Esc> <C-\><C-n>

" ------------------------------------------------------------------------------
" ZOOM UNZOOM
" ------------------------------------------------------------------------------
nnoremap <M-z> :MaximizerToggle<CR>

command! -bang -nargs=0 -range MaximizerToggle :call s:toggle(<bang>0)

fun! s:toggle(force)
	if exists('t:maximizer_sizes') && (a:force || (t:maximizer_sizes.after == winrestcmd()))
		call s:restore()
	elseif winnr('$') > 1
		call s:maximize()
	endif
endfun

fun! s:maximize()
	let t:maximizer_sizes = { 'before': winrestcmd() }
	vert resize | resize
	let t:maximizer_sizes.after = winrestcmd()
	normal! ze
endfun

fun! s:restore()
	if exists('t:maximizer_sizes')
		silent! exe t:maximizer_sizes.before
		if t:maximizer_sizes.before != winrestcmd()
			wincmd =
		endif
		unlet t:maximizer_sizes
		normal! ze
	end
endfun

" ------------------------------------------------------------------------------
" Swap Window
" ------------------------------------------------------------------------------
" " 移动窗口
" nnoremap <c-j> :call WindowSwap()<CR>:wincmd w<cr>:call WindowSwap()<cr>
" nnoremap <c-k> :call WindowSwap()<CR>:wincmd W<cr>:call WindowSwap()<cr>
" " 窗口交换 focus的窗口不变
" nnoremap sx :call WindowSwap()<CR>:wincmd w<cr>:call WindowSwap()<cr>:wincmd W<cr>
" nnoremap sX :call WindowSwap()<CR>:wincmd W<cr>:call WindowSwap()<cr>:wincmd w<cr>
"
" let s:markedWinNum = []
"
" " 第一次调用标记 第二次调用交换
" function! WindowSwap()
" 	if window_swap#HasMarkedWindow()
" 		call window_swap#DoWindowSwap()
" 	else
" 		let s:markedWinNum = [tabpagenr(),winnr()]
" 	endif
" endfunction
"
" function! window_swap#DoWindowSwap()
" 	if !window_swap#HasMarkedWindow()
" 		echom "WindowSwap: No window marked to swap! Mark a window first."
" 		return
" 	endif
" 	"Mark destination
" 	let curTab = tabpagenr()
" 	let curNum = winnr()
" 	let curView = winsaveview()
" 	let curBuf = bufnr( "%" )
" 	let targetWindow = s:markedWinNum
" 	exe "tabn " . targetWindow[0]
" 	exe targetWindow[1] . "wincmd w"
" 	"Switch to source and shuffle dest->source
" 	let markedView = winsaveview()
" 	let markedBuf = bufnr( "%" )
" 	"Hide and open so that we aren't prompted and keep history
" 	exe 'hide buf ' . curBuf
" 	call winrestview(curView)
" 	"Switch to dest and shuffle source->dest
" 	exe "tabn " . curTab
" 	exe curNum . "wincmd w"
" 	"Hide and open so that we aren't prompted and keep history
" 	exe 'hide buf ' . markedBuf
" 	call winrestview(markedView)
" 	let s:markedWinNum = []
" endfunction
"
" function! window_swap#HasMarkedWindow()
" 	if s:markedWinNum == []
" 		return 0
" 	else
" 		return 1
" 	endif
" endfunction

" ------------------------------------------------------------------------------
" Turn the word to upper or lower case
" ------------------------------------------------------------------------------
"  Turn the word under cursor to upper case
"inoremap <silent> <c-u> <Esc>viwUea
"
"" Turn the current word into title case
"inoremap <silent> <c-t> <Esc>b~lea


" ------------------------------------------------------------------------------
" Indent in visual mode
" ------------------------------------------------------------------------------
vnoremap < <gv
vnoremap > >gv


" ------------------------------------------------------------------------------
" Modify but don't save to register
" ------------------------------------------------------------------------------
" noremap c "_c
" noremap C "_C
" noremap cc "_cc

noremap s "_s
noremap S "_S

noremap x "_x
noremap X "_X


" ------------------------------------------------------------------------------
" Personal search
" ------------------------------------------------------------------------------
function s:get_selected_text(visual_mode) abort
	let [l:line_start, l:column_start] = [line("'<"), col("'<")]
	let [l:line_end, l:column_end] = [line("'>"), col("'>")]
	let l:lines = getline(l:line_start, l:line_end)
	if empty(a:visual_mode)
		let l:text = expand('<cword>')
	elseif a:visual_mode ==# "\<C-v>"
		for l:i in range(len(l:lines))
			let l:lines[l:i] = l:lines[l:i][l:column_start - 1:l:column_end - 1]
		endfor
		let l:text = join(l:lines, '')
	else
		let l:lines[-1] = l:lines[-1][:l:column_end - 1]
		let l:lines[0] = l:lines[0][l:column_start - 1:]
		let l:text = join(l:lines, '')
	endif
	return l:text
endfunction

function s:visual_secetion_search(visual_mode) abort
	let l:text = s:get_selected_text(a:visual_mode)
	let l:pattern = escape(l:text, "\\/.*'$^~[]")
	if empty(a:visual_mode)
		let l:pattern = '\<'.l:pattern.'\>'
	endif
	if a:visual_mode == 'v'
		let l:pattern = substitute(l:pattern, '^\_s\+'.'\|'.'\_s\+$', '', 'g')
		let l:pattern = substitute(l:pattern, '\n', '\\n', 'g')
		let l:pattern = substitute(l:pattern, '\s\+', '\\s*', 'g')
	endif
	" 	let l:pattern = substitute(l:pattern, '\n', '', '')
	" 	let l:pattern = substitute(l:pattern, '\t\+', '', 'g')
	let @/ = l:pattern
endfunction

" Visual mode pressing * or # searches for the current selection
nnoremap # <Cmd>call <SID>visual_secetion_search('') \| let v:hlsearch = 1 \| let v:searchforward = 0<CR>
nnoremap * <Cmd>call <SID>visual_secetion_search('') \| let v:hlsearch = 1 \| let v:searchforward = 1<CR>
vnoremap <silent> # :<C-u>call <SID>visual_secetion_search(visualmode()) \| let v:hlsearch = 1\| let v:searchforward = 0<CR>
vnoremap <silent> * :<C-u>call <SID>visual_secetion_search(visualmode()) \| let v:hlsearch = 1\| let v:searchforward = 1<CR>

" Search in selected region
vnoremap / <Esc>/\%V
vnoremap ? <Esc>?\%V

nnoremap <Esc> <Cmd>nohlsearch<CR>
nnoremap <Esc><Esc> <Cmd>nohlsearch<CR>


" ------------------------------------------------------------------------------
" Personal compile and run
" ------------------------------------------------------------------------------
function s:compile_run() abort
	execute "w"
	if &filetype == "c"
		execute "!gcc -Wall -std=c18 % -o %< && time ./%<"
	elseif &filetype == "cpp"
		execute "!g++ -Wall -std=c++20 % -o %< && time ./%<"
	elseif &filetype == "python"
		execute "!time python %"
	elseif &filetype == "vim"
		execute "source %"
	endif
endfunction

nnoremap <M-5> <Cmd>call <SID>compile_run()<CR>


" ------------------------------------------------------------------------------
" Personal comment
" ------------------------------------------------------------------------------
function s:comment()
	if index(["vim"], &filetype) >= 0
		let l:comment_symbol = '\"'
	elseif index(["c", "cpp"], &filetype) >= 0
		let l:comment_symbol = '\/\/'
	elseif index(["python"], &filetype) >= 0
		let l:comment_symbol = '\#'
	elseif index(["sh"], &filetype) >= 0
		let l:comment_symbol = '\#'
	else
		return
	endif
	silent execute 's/^/'.l:comment_symbol.' '
endfunction

noremap <C-_> :call <SID>comment()<CR>
noremap <C-?> :call <SID>comment()<CR>


" ------------------------------------------------------------------------------
" smooth_scroll
" ------------------------------------------------------------------------------
function s:smooth_scroll_up(num)
	let l:current_line = line('.')
	let l:first_line = line('w0')
	let l:line = 1

	if l:first_line - a:num >= l:line
		let l:num = a:num
		let l:_num = 0

	elseif l:first_line == l:line
		let l:num = 0
		let l:_num = - l:line + l:current_line
		if l:_num > a:num
			let l:_num = a:num
		endif

	else
		let l:num = - l:line + l:first_line
		let l:_num = a:num - l:num
	endif

	if l:num
		for i in range(l:num)
			normal! k
			redraw
		endfor
	endif

	if l:_num
		execute 'normal! '.l:_num.'k'
	endif
endfunction

function s:smooth_scroll_down(num)
	let l:current_line = line('.')
	let l:last_line = line('w$')
	let l:line = line('$')

	if l:last_line + a:num <= l:line
		let l:num = a:num
		let l:_num = 0

	elseif l:last_line == l:line
		let l:num = 0
		let l:_num = l:line - l:current_line
		if l:_num > a:num
			let l:_num = a:num
		endif

	else
		let l:num = l:line - l:last_line
		let l:_num = a:num - l:num
	endif

	if l:num
		for i in range(l:num)
			normal! j
			redraw
		endfor
	endif

	if l:_num
		execute 'normal! '.l:_num.'j'
	endif
endfunction

noremap <C-u> <Cmd>call <SID>smooth_scroll_up(&scroll * 1)<CR>
noremap <C-d> <Cmd>call <SID>smooth_scroll_down(&scroll * 1)<CR>
noremap <C-b> <Cmd>call <SID>smooth_scroll_up(&scroll * 2)<CR>
noremap <C-f> <Cmd>call <SID>smooth_scroll_down(&scroll * 2)<CR>


" ------------------------------------------------------------------------------
" Enhancement f F t T
" ------------------------------------------------------------------------------
function s:forward_cancel(...) abort
	if get(s:, 'is_pending', v:false)
		call feedkeys("\<ESC>")
	endif
endfunction

function s:forward_repeat(action) abort
	if !exists('s:forward_action')
		return
	endif
	if a:action ==# ';'
		call s:forward(s:forward_action, s:search_char, v:true)
	else
		call s:forward(s:forward_action ==# 'f' ? 'F' : 'f', s:search_char, v:true)
	endif
endfunction

function s:forward(action, ...) abort
	let s:is_pending = v:true
	if a:0 >= 1
		let s:search_char = a:1
	else
		let s:timer = timer_start(1000, function('s:forward_cancel'))
		let s:search_char = nr2char(getchar())
	endif
	if !get(a:, '2', v:false)
		let s:forward_action = a:action
	endif
	if exists('s:timer')
		call timer_stop(s:timer)
		unlet s:timer
	endif
	unlet s:is_pending
	if s:search_char ==# 27
		let s:search_char = ''
		return
	endif
	call search('[' . s:search_char . ']', a:action ==# 'F' ? 'b' : '')
endfunction

" nnoremap <silent> f :call <SID>forward('f')<CR>
" nnoremap <silent> F :call <SID>forward('F')<CR>
" nnoremap <silent> ; :call <SID>forward_repeat(';')<CR>
" nnoremap <silent> , :call <SID>forward_repeat(',')<CR>
