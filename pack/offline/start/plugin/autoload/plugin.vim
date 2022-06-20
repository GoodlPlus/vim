" ------------------------------------------------------------------------------
" Plugin
" ------------------------------------------------------------------------------
if exists('g:plugin#loaded')
    finish
else
    let g:plugin#loaded = 1
endif

let s:config_name = fnameescape('config')
let s:config_path = fnameescape(join([g:_VIM_PATH, s:config_name], '/'))
let s:pack_path = fnameescape(join([g:_VIM_PATH, 'pack/online/opt'], '/'))
let s:plugin_dict = {}
let s:debug_mode = 0

function plugin#plugin(repo, info = {})
    let l:info = deepcopy(a:info)
    let l:plugin_name = fnamemodify(a:repo, ':t')
    if a:repo =~# 'https\?://'
        let l:info['url'] = a:repo
    endif
    let s:plugin_dict[l:plugin_name] = l:info
endfunction

function s:get_plugin_path(plugin_name)
    return fnameescape(join([s:pack_path, a:plugin_name], '/'))
endfunction

function s:load_plugin(plugin_name)
    try
        execute 'packadd '.a:plugin_name
    catch /^Vim\%((\a\+)\)\=:E919:/
        echomsg "Not exists plugin: ".a:plugin_name
    endtry
    call SourceVim(s:config_path, a:plugin_name)
endfunction

function plugin#load_plugin_all()
    for l:plugin_name in keys(s:plugin_dict)
        call <SID>load_plugin(l:plugin_name)
    endfor
endfunction

function s:exit_cb(channel, message) abort
    let l:job_info = job_info(a:channel)
    for l:i in l:job_info['cmd']
        if l:i ==# 'clone'
            let l:type = 'install'
        elseif l:i ==# 'pull'
            let l:type = 'update'
        endif
        if l:i =~# s:pack_path
            let l:plugin_name = fnamemodify(l:i, ':t')
        endif
    endfor
    if l:job_info['exitval'] == 0
        echomsg join(['Successfully:', l:type, l:plugin_name])
        call <SID>post_process(l:plugin_name)
    else
        echomsg join(['Failed:', l:type, l:plugin_name])
    endif
    if s:debug_mode
        echomsg "exit_cb: " l:job_info
    endif
endfunction

function s:out_cb(channel, message) abort
    if s:debug_mode
        echomsg "out_cb: ".a:message
    endif
endfunction

function s:err_cb(channel, message) abort
    if s:debug_mode
        echomsg "err_cb: ".a:message
    endif
endfunction

let s:callback =
\ {
    \ 'mode': 'nl',
    \ 'exit_cb': function('<SID>exit_cb'),
    \ 'out_cb': function('<SID>out_cb'),
    \ 'err_cb': function('<SID>err_cb'),
    \ 'stoponexit': '',
\ }

function s:exists_plugin(plugin_name)
    let l:plugin_path = <SID>get_plugin_path(a:plugin_name)
    if empty(glob(l:plugin_path))
        return v:false
    else
        return v:true
    endif
endfunction

" ------------------------------------------------------------------------------
" Utils
" ------------------------------------------------------------------------------
function s:get_plugin_info_dict(plugin_name)
    return s:plugin_dict[a:plugin_name]
endfunction

" ------------------------------------------------------------------------------
" Git Process
" ------------------------------------------------------------------------------
function s:git_process(plugin_name)
    let l:cmd = []
    let l:plugin_info_dict = <SID>get_plugin_info_dict(a:plugin_name)
    if has_key(l:plugin_info_dict, 'branch')
        let l:cmd += <SID>branch_process(l:plugin_info_dict['branch'])
    endif
    return l:cmd
endfunction

function s:branch_process(branch)
    let l:cmd =
    \ [
        \ '-b',
        \ a:branch,
    \ ]
    return l:cmd
endfunction

" ------------------------------------------------------------------------------
" Post Process
" ------------------------------------------------------------------------------
function s:post_process(plugin_name)
    let l:plugin_info_dict = <SID>get_plugin_info_dict(a:plugin_name)
    if has_key(l:plugin_info_dict, 'cmd')
        call <SID>cmd_process(l:plugin_info_dict['cmd'])
    endif
endfunction

function s:cmd_process(cmd)
    execute a:cmd
endfunction

" ------------------------------------------------------------------------------
" Plugin Process
" ------------------------------------------------------------------------------
function s:install_plugin(plugin_name)
    let l:plugin_path = s:get_plugin_path(a:plugin_name)
    let l:plugin_info_dict = <SID>get_plugin_info_dict(a:plugin_name)
    let l:url = l:plugin_info_dict['url']
    let l:url = substitute(l:url, '\(https://\)\@<=github\.com', 'hub.fastgit.xyz', '')
"   let l:url = substitute(l:url, 'https://github.com', 'https://github.com.cnpmjs.org', '')
    let l:cmd =
    \ [
        \ 'git',
        \ 'clone',
        \ '--depth=1',
        \ l:url,
        \ l:plugin_path,
    \ ]
    let l:cmd += <SID>git_process(a:plugin_name)
    call job_start(l:cmd, s:callback)
endfunction

function plugin#install_plugin_all()
    for l:plugin_name in keys(s:plugin_dict)
        if <SID>exists_plugin(l:plugin_name) == v:false && has_key(s:plugin_dict[l:plugin_name], 'url')
            call <SID>install_plugin(l:plugin_name)
        endif
    endfor
endfunction

function s:update_plugin(plugin_name)
    let l:plugin_path = <SID>get_plugin_path(a:plugin_name)
    let l:cmd =
    \ [
        \ 'git',
        \ '-C',
        \ l:plugin_path,
        \ 'pull',
        \ '--all',
    \ ]
    call job_start(l:cmd, s:callback)
endfunction

function plugin#update_plugin_all()
    for l:plugin_name in keys(s:plugin_dict)
        if <SID>exists_plugin(l:plugin_name) == v:true && has_key(s:plugin_dict[l:plugin_name], 'url')
            call <SID>update_plugin(l:plugin_name)
        endif
    endfor
endfunction

function plugin#uninstall_plugin_all()
    let l:plugin_name_list = readdir(s:pack_path)
    for l:plugin_name in l:plugin_name_list
        if !has_key(s:plugin_dict, l:plugin_name)
            let l:delete_result = delete(<SID>get_plugin_path(l:plugin_name), 'rf')
            if l:delete_result == v:false
                echomsg join(["Uninstall", l:plugin_name, "successfully"])
            endif
        endif
    endfor
endfunction
