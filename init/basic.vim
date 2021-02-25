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

let &viminfofile = fnameescape(join([g:home_path, 'viminfo'], '/'))
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
let s:saved_view_dict = {}
let s:modify_view_list = []

function s:_write()
	let l:win_view = winsaveview()
	" call writefile([expand('%:p'), string(l:win_view), ''], 'vimview', 'Sa')
" 	echomsg l:win_view
endfunction

function s:read_view()
	let l:lines = readfile('vimview')
	let l:offset = 3
	let l:i = 0
	let l:line_number = len(l:lines)
	while l:i + 1 < l:line_number
		let s:saved_view_dict[l:lines[l:i]] = l:lines[l:i + 1]
		let l:i += l:offset
	endwhile
	echomsg s:saved_view_dict
endfunction

function s:save_view(file_name)
	let l:view = winsaveview()
	let l:view_value = []
	for l:value in values(l:view)
		call add(l:view_value, l:value)
	endfor
	let l:view_value = join(l:view_value)
	let s:saved_view_dict[a:file_name] = l:view_value
	call add(s:modify_view_list, a:file_name)
endfunction

" call <SID>save_view(expand('%:~'))
let start_time = reltime()
call <SID>read_view()
echomsg reltimestr(reltime(start_time))

function s:restore_window_view(file_name)
	let l:view = winsaveview()
	let l:view_key = []
	for l:key in keys(l:view)
		call add(l:view_key, l:key)
	endfor
	let l:view = get(s:saved_view_dict, a:file_name, '')
	if !empty(l:view_value)
		let l:view_value = split(l:view_value)
		let l:value_index = 0
		for l:key in l:view_key
			let l:view[l:key] = l:view_value[l:value_index]
			let l:value_index += 1
		endfor
		call winrestview(s:saved_view_dict[a:file_name])
	endif
endfunction

augroup auto_resume_last_position
	autocmd!
" 	" Return to last edit position when opening a file
" 	" See https://vim.fandom.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" 	autocmd BufReadPost
" 		\ * if line("'\"") >= 1 && line("'\"") <= line("$") && &filetype !~# 'commit'
" 		\ | 	execute "normal! g`\""
" 		\ | endif
" 	" When switching buffers, preserve window view.
" 	" See https://vim.fandom.com/wiki/Avoid_scrolling_when_switch_buffers
" 	autocmd BufLeave
" 		\ * if !&diff
" 		\ | 	let b:saved_buffer_view = winsaveview()
" 		\ | endif
" 	autocmd BufEnter
" 		\ * if !&diff && exists('b:saved_buffer_view') && winsaveview()['lnum'] == 1 && winsaveview()['col'] == 0
" 		\ | 	call winrestview(b:saved_buffer_view)
" 		\ | endif
" 	autocmd BufLeave * call <SID>_write()
" 	autocmd BufEnter * call <SID>_read()
augroup END
" call <SID>read_window_view()
let start_time = reltime()
" echomsg reltimestr(reltime(start_time))


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
