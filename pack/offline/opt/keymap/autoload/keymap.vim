" ------------------------------------------------------------------------------
" Keymap
" ------------------------------------------------------------------------------
if exists('g:keymap#loaded')
    finish
else
    let g:keymap#loaded = 1
endif

" ------------------------------------------------------------------------------
" Personal alt keymaps
" https://zhuanlan.zhihu.com/p/20902166
" https://skywind3000.com/blog/archives/1846/
" https://github.com/skywind3000/vim/blob/9002b44618c7aa24f19595739996cdee8eddb5f5/plugin/altmeta.vim
" ------------------------------------------------------------------------------
function keymap#init_meta(mode) abort
    function s:set_meta_key(mode, key)
        if a:mode == 0
            execute "set <M-".a:key.">=\e".a:key
        else
            execute "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    let l:array = [')', '!', '@', '#', '$', '%', '^', '&', '*', '(']
    for i in range(10)
        call <SID>set_meta_key(a:mode, nr2char(char2nr('0') + i))
        call <SID>set_meta_key(a:mode, l:array[i])
    endfor
    for i in range(26)
        call <SID>set_meta_key(a:mode, nr2char(char2nr('a') + i))
        call <SID>set_meta_key(a:mode, nr2char(char2nr('A') + i))
    endfor
    for c in [',', '.', '/', ';', "'", '[', ']', '\', '-', '=', '`']
        call <SID>set_meta_key(a:mode, c)
    endfor
    " ['<', '>', '?', ':', '{', '}', '|', '_', '+', '~']
    for c in ['<', '?', ':', '{', '}', '_', '+', '~']
        call <SID>set_meta_key(a:mode, c)
    endfor
    delfunction <SID>set_meta_key
endfunction

function keymap#toggle(force) abort
    if exists('t:maximizer_sizes') && (a:force || (t:maximizer_sizes.after == winrestcmd()))
        call s:restore()
    elseif winnr('$') > 1
        call s:maximize()
    endif
endfunction

function s:maximize() abort
    let t:maximizer_sizes = { 'before': winrestcmd() }
    vertical resize | resize
    let t:maximizer_sizes.after = winrestcmd()
    normal! ze
endfunction

function s:restore() abort
    if exists('t:maximizer_sizes')
        silent! exe t:maximizer_sizes.before
        if t:maximizer_sizes.before != winrestcmd()
            wincmd =
        endif
        unlet t:maximizer_sizes
        normal! ze
    end
endfunction

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
"   if window_swap#HasMarkedWindow()
"       call window_swap#DoWindowSwap()
"   else
"       let s:markedWinNum = [tabpagenr(),winnr()]
"   endif
" endfunction
"
" function! window_swap#DoWindowSwap()
"   if !window_swap#HasMarkedWindow()
"       echom "WindowSwap: No window marked to swap! Mark a window first."
"       return
"   endif
"   "Mark destination
"   let curTab = tabpagenr()
"   let curNum = winnr()
"   let curView = winsaveview()
"   let curBuf = bufnr( "%" )
"   let targetWindow = s:markedWinNum
"   exe "tabn " . targetWindow[0]
"   exe targetWindow[1] . "wincmd w"
"   "Switch to source and shuffle dest->source
"   let markedView = winsaveview()
"   let markedBuf = bufnr( "%" )
"   "Hide and open so that we aren't prompted and keep history
"   exe 'hide buf ' . curBuf
"   call winrestview(curView)
"   "Switch to dest and shuffle source->dest
"   exe "tabn " . curTab
"   exe curNum . "wincmd w"
"   "Hide and open so that we aren't prompted and keep history
"   exe 'hide buf ' . markedBuf
"   call winrestview(markedView)
"   let s:markedWinNum = []
" endfunction
"
" function! window_swap#HasMarkedWindow()
"   if s:markedWinNum == []
"       return 0
"   else
"       return 1
"   endif
" endfunction

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

" https://github.com/skywind3000/vim/blob/9002b44618c7aa24f19595739996cdee8eddb5f5/plugin/search_plus.vim
function keymap#visual_secetion_search(visual_mode) abort
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
    "   let l:pattern = substitute(l:pattern, '\n', '', '')
    "   let l:pattern = substitute(l:pattern, '\t\+', '', 'g')
    let @/ = l:pattern
endfunction

" ------------------------------------------------------------------------------
" Personal compile and run
" ------------------------------------------------------------------------------
function keymap#compile_run() abort
    execute 'w'
    let l:splitbelow = &splitbelow
    set splitbelow
    if &filetype == 'c'
        terminal ++shell gcc -Wall -Wextra -std=c18 % -o %< && time ./%< && rm ./%<
    elseif &filetype == 'cpp'
        terminal ++shell g++ -Wall -Wextra -std=c++20 % -o %< && time ./%< && rm ./%<
    elseif &filetype == 'python'
        terminal ++shell time python3 %
    elseif &filetype == 'vim'
        execute 'source %'
    endif
    let &splitbelow = l:splitbelow
endfunction

" ------------------------------------------------------------------------------
" Personal comment
" https://github.com/skywind3000/vim/blob/9002b44618c7aa24f19595739996cdee8eddb5f5/plugin/commentary.vim
" ------------------------------------------------------------------------------
function keymap#comment() abort
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

" ------------------------------------------------------------------------------
" smooth_scroll
" ------------------------------------------------------------------------------
function keymap#smooth_scroll_up(num)
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

function keymap#smooth_scroll_down(num)
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

" ------------------------------------------------------------------------------
" Enhancement f F t T
" ------------------------------------------------------------------------------
function s:forward_cancel(...) abort
    if get(s:, 'is_pending', v:false)
        call feedkeys("\<ESC>")
    endif
endfunction

function keymap#forward_repeat(action) abort
    if !exists('s:forward_action')
        return
    endif
    if a:action ==# ';'
        call s:forward(s:forward_action, s:search_char, v:true)
    else
        call s:forward(s:forward_action ==# 'f' ? 'F' : 'f', s:search_char, v:true)
    endif
endfunction

function keymap#forward(action, ...) abort
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
