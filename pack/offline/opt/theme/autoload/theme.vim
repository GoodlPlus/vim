" ------------------------------------------------------------------------------
" Theme
" ------------------------------------------------------------------------------
if exists('g:theme#loaded')
    finish
else
    let g:theme#loaded = 1
endif

let s:fileformat_icon =
\ {
    \ 'unix': '',
    \ 'dos': '',
    \ 'mac': '',
\ }

let s:default_file_icon = ''

let s:default_folder_icon = ''

let s:file_icon =
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

let s:file_palette =
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

" ------------------------------------------------------------------------------
" Highlight Config
" ------------------------------------------------------------------------------
let s:Default = {'guifg': '#a89984', 'guibg': '#1d2021'}
let s:Seletect = {'guifg': '#ebdbb2', 'guibg': '#3c3836'}
let s:Fill = {'guifg': 'NONE', 'guibg': 'NONE'}

let s:highlight_config =
\ {
    \ 'StatusLine':         [{'NONE': 1}, {'guifg': s:Seletect['guifg'], 'guibg': s:Seletect['guibg']}],
    \ 'StatusLineNC':       [{'NONE': 1}, {'guifg': s:Default['guifg'], 'guibg': s:Default['guibg']}],
    \ 'StatusLineFill':       [{'NONE': 1}, {'guifg': s:Fill['guifg'], 'guibg': s:Fill['guibg']}],
    \ 'TabLine':            [{'NONE': 1}, {'guifg': s:Default['guifg'], 'guibg': s:Default['guibg']}],
    \ 'TabLineSel':         [{'NONE': 1}, {'guifg': s:Seletect['guifg'], 'guibg': s:Seletect['guibg']}],
    \ 'TabLineFill':        [{'NONE': 1}, {'guifg': s:Fill['guifg'], 'guibg': s:Fill['guibg']}],
    \ 'LineNr':             [{'NONE': 0}, {'guifg': s:Default['guifg']}],
    \ 'CursorLineNr':       [{'NONE': 0}, {'guifg': s:Seletect['guifg']}],
    \ 'SuccessMsg':       [{'NONE': 0}, {'cterm': 'bold', 'ctermfg': '142', 'gui': 'bold', 'guifg': '#b8bb26'}],
\ }
"     \
"     \ 'SpellBad':           [{'NONE': 1}, {'cterm': 'underline'}],
"     \
"     \ 'EndOfBuffer':        [{'NONE': 1}, {'guifg': s:bg_0}],
"     \
"     \ 'Todo':               [{'NONE': 1}, {'guifg': s:bg_0, 'guibg': s:fg_1}],
"     \ 'SignColumn':         [{'NONE': 0}, {'guibg': s:bg_0}],
"     \ 'FoldColumn':         [{'NONE': 0}, {'guibg': s:bg_0}],
"
"   \
    " \ 'CursorLineNr':         [{'NONE': 1}, {'guifg': s:fg_1, 'guibg': s:bg_0}],
    " \ 'SignColumn':       [{'NONE': 0}, {'guibg': s:bg_0}],
    " \
    " \ 'Search':           [{'NONE': 1}, {'guifg': s:bg_0, 'guibg': s:fg_1}],
    " \ 'IncSearch':            [{'NONE': 1}, {'guifg': s:bg_0, 'guibg': s:fg_1}],

function s:get_highlight_palette(file_type, status) abort
    if empty(a:file_type)
        let l:icon = s:default_file_icon
        let l:palette = s:file_palette['_']
    else
        let l:palette = get(s:file_palette, a:file_type, s:file_palette['_'])
    endif
    let l:highlight_group = join(['palette', a:file_type, a:status], '_')
    if !highlight_exists(l:highlight_group)
        execute printf('highlight %s guifg=%s guibg=%s', l:highlight_group, l:palette['guifg'], a:status ? s:Seletect['guibg'] : s:Default['guibg'])
    endif
    return '%#'.l:highlight_group.'#'
endfunction

" ------------------------------------------------------------------------------
" TabLine
" ------------------------------------------------------------------------------
function s:get_file_type(buffer_index, window_index = 0) abort
    let l:file_extension = fnamemodify(bufname(a:buffer_index), ':e')
    if !empty(l:file_extension) && has_key(s:file_icon, l:file_extension)
        return l:file_extension
    else
        if a:window_index
            return getwinvar(a:window_index, '&filetype')
        else
            return getbufvar(a:buffer_index, '&filetype')
        endif
    endif
endfunction

function s:get_file_icon(file_type) abort
    return get(s:file_icon, a:file_type, s:default_file_icon)
endfunction

function theme#set_highlight_group() abort
    for [l:highlight_group_name, l:highlight_group_arguments] in items(s:highlight_config)
        let l:command = 'highlight '.l:highlight_group_name.(get(l:highlight_group_arguments[0], 'NONE', 0) ? ' NONE' : '')
        for [l:argument_name, l:argument_value] in items(l:highlight_group_arguments[1])
            let l:command .= ' '.l:argument_name.'='.l:argument_value
        endfor
        execute l:command
    endfor
endfunction

function TabLine() abort
    let l:tabline = ''
    for l:i in range(1, bufnr('$'))
        if buflisted(l:i)
            let l:file_type = <SID>get_file_type(l:i)
            if l:i == bufnr('%')
                let l:highlight_default = '%#TabLineSel#'
                let l:highlight_icon = <SID>get_highlight_palette(l:file_type, 1)
            else
                let l:highlight_default = '%#TabLine#'
"               let l:highlight_icon = '%#TabLine#'
                let l:highlight_icon = <SID>get_highlight_palette(l:file_type, 0)
            endif
            let l:tabline .= l:highlight_default
            let l:tabline .= ' %*'

            let l:tabline .= l:highlight_icon
            let l:tabline .= <SID>get_file_icon(l:file_type)
            let l:tabline .= ' %*'

            let l:tabline .= l:highlight_default
            let l:tabline .= fnamemodify(bufname(l:i), ':t')
            let l:tabline .= getbufvar(l:i, '&modified') ? ' +' : ''
            let l:tabline .= ' %*'
        endif
    endfor
    let l:tabline .= '%#TabLineFill#'
    let l:tabline .= '%='
    let l:tabline .= '%*'
    return l:tabline
endfunction

function s:get_file_name_by_buffer_index(buffer_index) abort
    let l:file_name = fnamemodify(bufname(a:buffer_index), ':~')
    return l:file_name
endfunction

function theme#tabeline()
    set tabline=%!TabLine()
endfunction

" ------------------------------------------------------------------------------
" StatusLine
" ------------------------------------------------------------------------------
function StatusLine(window_index, active) abort
    let l:buffer_index = winbufnr(a:window_index)
    let l:file_type = <SID>get_file_type(l:buffer_index, a:window_index)
    let l:file_name = <SID>get_file_name_by_buffer_index(l:buffer_index)
    let l:fileformat_icon = s:fileformat_icon[getwinvar(a:window_index, '&fileformat')]

    let l:statusline = ''
    let l:statusline .= s:get_highlight_palette(l:file_type, a:active)
    let l:statusline .= ' '.<SID>get_file_icon(l:file_type).' '
    let l:statusline .= '%*'
    let l:statusline .= a:active ? '%#StatusLine#' : '%#StatusLineNC#'
    let l:statusline .= l:file_name.' '
    let l:statusline .= '%{&readonly ? " " : ""}'
    let l:statusline .= '%{&modified ? "+ " : ""}'
    let l:statusline .= '%*'

    let l:statusline .= '%#StatusLineFill#'
    let l:statusline .= '%='
    let l:statusline .= '%*'

    let l:statusline .= a:active ? '%#StatusLine#' : '%#StatusLineNC#'
    let l:statusline .= ' %p%%'
    let l:statusline .= ' %{(&fileencoding == "" ? &encoding : &fileencoding).(&bomb ? ",BOM" : "")}'
    let l:statusline .= ' '.l:fileformat_icon.' '
    let l:statusline .= '%*'
    return l:statusline
endfunction

function theme#statusline() abort
    let l:now_window_index = winnr()
    let l:previous_window_index = winnr('#')
    let l:window_number = winnr('$')

    for l:window_index in range(1, l:window_number)
        let l:active = l:window_index == l:now_window_index
        call setwinvar(l:window_index, "&statusline", StatusLine(l:window_index, l:active))
    endfor
endfunction
