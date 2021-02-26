" ------------------------------------------------------------------------------
" basic
" ------------------------------------------------------------------------------

" remove vi compatible
" set nocompatible " Default on

syntax enable
filetype plugin indent on
set termguicolors
set background=dark

let mapleader=' '

" Ignore case when searching
set ignorecase smartcase

" Set encoding format
set encoding=utf-8
" set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,gb18030,big5,euc-jp,latin1
" set fileformat=unix
set fileformats=unix,dos,mac

" Save undo buffer in undodirectory
" set undofile
" set backupdir
" set viewdir
" set swapfile
" set undodir=g:homepath/undodir

" Set spell check
set spell

" Show line number
set number
" set relativenumber
set signcolumn=number
set foldcolumn=1
" set numberwidth=5
set scrolloff=5

" set nowrap
" set linebreak
set sidescroll=1
set sidescrolloff=5

set synmaxcol=256
set regexpengine=1

" Highlight current line
set cursorlineopt=number cursorline

" Set cursor shape
" See https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\e[6 q" "SI = INSERT mode
let &t_SR = "\e[4 q" "SR = REPLACE mode
let &t_EI = "\e[2 q" "EI = NORMAL mode (ELSE)
" let &t_Cs = "\e[4:3m"
" let &t_Ce = "\e[4:0m"

" Set indent width
" set autoindent " Default on
set shiftwidth=4
" set cindent "Default on
" set expandtab
set tabstop=4
" set smarttab
" set softtabstop=4
" set shiftround

set list
set listchars=tab:\╏\ ,
" set listchars=tab:\ￜ\
" set listchars=tab:\❙\
" set listchars=tab:\ﺍ\

" Add matching pairs of charaters and highlight matching brackets
set matchpairs+=<:>

" Set backspace mode
set backspace=indent,eol,start

" Dynamically show results when searching
set incsearch hlsearch

" For regular expressions turn magic on
set magic

" Enable mouse usage (all modes)
set mouse=n

" Don't show mode
set noshowmode

" Set tabline
set showtabline=2

" Always show statusline
set laststatus=2

" Screen will not be redrawn
set lazyredraw
set ttyfast

set wildmenu
set pumheight=10

set complete+=kspell

set hidden
set shortmess=acs
" autocmd BufEnter * set formatoptions-=cro

set updatetime=500

" Always report number of lines changed
set report=0

let &viminfofile = fnameescape(join([g:_VIM_PATH, 'viminfo'], '/'))
set viminfo=%,'999,/999,:999,<999999,@999,c,f1,s1024,

" ------------------------------------------------------------------------------
" Timeout time
" ------------------------------------------------------------------------------
" set timeout " Default on
set timeoutlen=500
set ttimeout
if $TMUX != ""
	set ttimeoutlen=10
elseif &ttimeoutlen > 50 || &ttimeoutlen <= 0
	set ttimeoutlen=50
endif


" ------------------------------------------------------------------------------
" DiffOrig
" ------------------------------------------------------------------------------
command DiffOrig vert new | set buftype=nofile | r ++edit # | 0d_
	\ | diffthis | wincmd p | diffthis


" ------------------------------------------------------------------------------
" Resume last position
" ------------------------------------------------------------------------------
let s:vimview_name = 'vimview'
let s:vimview_path = fnameescape(join([g:_VIM_PATH, s:vimview_name], '/'))
let s:modify_view_dict = {}
let s:modify_view_list = []

function s:restore_view()
	let l:lines = readfile(s:vimview_path)
	let l:current_view = winsaveview()
	if l:current_view['lnum'] != 1 || l:current_view['col'] != 0
		return
	endif
	let l:offset = 3
	let l:line_number = len(l:lines)
	let l:file_name = fnameescape(expand('%:~'))
	let l:index = index(s:lines, l:file_name)
	if l:index == -1
		return
	endif
	let l:view_key = []
	for l:key in keys(l:current_view)
		call add(l:view_key, l:key)
	endfor
	let l:saved_view = {}
	let l:saved_view_value = split(s:lines[l:index + 1])
	let l:value_index = 0
	for l:key in l:view_key
		let l:saved_view[l:key] = l:saved_view_value[l:value_index]
		let l:value_index += 1
	endfor
	call winrestview(l:saved_view)
endfunction

function s:save_view()
	let l:lines = readfile(s:vimview_path)
	if !empty(l:lines)
		call add(s:lines, '')
	endif
	let l:current_view = winsaveview()
	let l:file_name = fnameescape(expand('%:~'))
	if empty(l:file_name)
		return
	endif
	let l:view_value = []
	for l:value in values(l:current_view)
		call add(l:view_value, l:value)
	endfor
	let l:view_value = join(l:view_value)
	let l:index = index(s:lines, l:file_name)
	if l:index != -1
		unlet s:lines[l:index:l:index + 2]
	endif
	call add(s:lines, l:file_name)
	call add(s:lines, l:view_value)
endfunction

function s:write_view()
	call <SID>read_view()
	for [l:key, l:value] in items(s:modify_view_dict)
		let s:saved_view_dict[l:key] = l:value
	endfor
	let l:lines = []
	for [l:key, l:value] in items(s:saved_view_dict)
		let l:lines += [l:key, l:value, '']
	endfor
	unlet l:lines[-1]
	call writefile(l:lines, s:vimview_path)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function s:write_view()
	call <SID>read_view()
	for [l:key, l:value] in items(s:modify_view_dict)
		let s:saved_view_dict[l:key] = l:value
	endfor
	let l:lines = []
	for [l:key, l:value] in items(s:saved_view_dict)
		let l:lines += [l:key, l:value, '']
	endfor
	unlet l:lines[-1]
	call writefile(l:lines, s:vimview_path)
endfunction

function s:read_view()
	let s:saved_view_line_dict = {}
	let s:lines = readfile(s:vimview_path)
	let l:offset = 3
	let l:i = 0
	let l:line_number = len(s:lines)
	while l:i + 1 < l:line_number
		let s:saved_view_line_dict[l:lines[l:i]] = l:i
		let l:i += l:offset
	endwhile
endfunction

function s:save_view()
	let l:current_view = winsaveview()
	let l:file_name = expand('%:~')
	if empty(l:file_name)
		return
	endif
	let l:view_value = []
	for l:value in values(l:current_view)
		call add(l:view_value, l:value)
	endfor
	let l:view_value = join(l:view_value)
	let s:modify_view_dict[l:file_name] = l:view_value
	let l:index = index(s:modify_view_list, l:file_name)
	if l:index != -1
		unlet s:modify_view_list[l:index]
	endif
	call add(s:modify_view_list, l:file_name)
endfunction

function s:restore_view()
	let l:current_view = winsaveview()
	if l:current_view['lnum'] != 1 || l:current_view['col'] != 0
		return
	endif
	let l:file_name = expand('%:~')
	let l:view_key = []
	for l:key in keys(l:current_view)
		call add(l:view_key, l:key)
	endfor
	let l:saved_view_line = get(s:saved_view_line_dict, l:file_name, -1)
	if l:saved_view_line == -1
		return
	endif
	let l:saved_view = {}
	let l:saved_view_value = split(s:lines[l:saved_view_line + 1])
	let l:value_index = 0
	for l:key in l:view_key
		let l:saved_view[l:key] = l:saved_view_value[l:value_index]
		let l:value_index += 1
	endfor
	call winrestview(l:saved_view)
endfunction

augroup auto_resume_last_position
	autocmd!
" 	autocmd BufLeave,VimLeavePre * call <SID>save_view()
" 	autocmd BufEnter * call <SID>restore_view()
" 	autocmd VimLeave * call <SID>write_view()
	autocmd BufLeave,VimLeavePre * call <SID>save_view()
	autocmd BufEnter * call <SID>restore_view()
augroup END

call <SID>read_view()


" ------------------------------------------------------------------------------
" Dynamically smartcase
" ------------------------------------------------------------------------------
" Do not use smart case in command line mode,
" extracted from https://vi.stackexchange.com/q/16509/15292
augroup auto_smartcase
	autocmd!
	autocmd CmdLineEnter : set nosmartcase
	autocmd CmdLineLeave : set smartcase
augroup END


" ------------------------------------------------------------------------------
" Remove trailing space
" ------------------------------------------------------------------------------
augroup auto_remove_trailing_space
	autocmd!
	autocmd BufWritePre
		\ * let b:last_pos = [line('.'), col('.')]
		\ | silent %s/\s\+$//e
		\ | call cursor(b:last_pos)
		\ | unlet b:last_pos
augroup END
