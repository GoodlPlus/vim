if exists('g:translator#loaded')
    finish
else
    let g:translator#loaded = 1
endif

let s:translator_file = expand('<sfile>:p:h').'/../utils/translator.py'

function translator#translate_out_cb(channel, message) abort
    let s:info .= a:message
endfunction

function translator#translate_err_cb(channel, message) abort
    echomsg "err_cb:" a:message
endfunction

function translator#translate_exit_cb(channel, message) abort
    call popup_atcursor(s:info, {'pos':'botleft', 'line': 'cursor-1', 'col': 'cursor'})
endfunction

function translator#get_selected_text(mode) abort
    if a:mode == 'n'
        let l:text = expand('<cword>')
    else
        let [l:line_start, l:column_start] = [line("'<"), col("'<")]
        let [l:line_end, l:column_end] = [line("'>"), col("'>")]
        let l:lines = getline(l:line_start, l:line_end)
        if l:line_start == l:line_end
            let l:lines[0] = l:lines[0][column_start - 1:column_end - 1]
        else
            let l:lines[0] = l:lines[0][column_start - 1:]
            let l:lines[-1] = l:lines[-1][:column_end - 1]
        endif
        let l:text = join(l:lines, "\n")
    endif
    return l:text
endfunction

function translator#start(args) abort
    let l:mode = a:args[0]
    let l:args = split(a:args[1:])
    let l:text = translator#get_selected_text(l:mode)
    let l:callback =
    \ {
        \ 'out_cb': function('translator#translate_out_cb'),
        \ 'err_cb': function('translator#translate_err_cb'),
        \ 'exit_cb': function('translator#translate_exit_cb'),
    \ }
    let l:text = escape(l:text, '"')
    let l:cmd =
    \ [
        \ 'python',
        \ s:translator_file,
        \ l:text,
    \ ]
    let l:cmd += l:args
    let s:info = ''
    call job_start(l:cmd, l:callback)
endfunction
