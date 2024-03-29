" ------------------------------------------------------------------------------
" basic
" ------------------------------------------------------------------------------

" remove vi compatible
" set nocompatible " Default on

syntax enable
filetype plugin indent on

" Set cursor shape
" See https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\e[6 q" "SI = INSERT mode
let &t_SR = "\e[4 q" "SR = REPLACE mode
let &t_EI = "\e[2 q" "EI = NORMAL mode (ELSE)
" Enable undercurls in terminal
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"
" Enable underline colors (ANSI), see alacritty #4660
let &t_AU = "\e[58;5;%dm"
" Enable true color
" let &t_8u = "\e[58;2;%lu;%lu;%lum"
" if &term =~# '^\(tmux\|screen\|st\|alacritty\)'
"     let &t_8f = "\e[38;2;%lu;%lu;%lum"
"     let &t_8b = "\e[48;2;%lu;%lu;%lum"
" endif

set termguicolors
set background=dark

let mapleader=' '
" let maplocalleader = "\<CR>"

" Ignore case when searching
set ignorecase smartcase

" Set encoding format
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,gb18030,big5,euc-jp,latin1
set fileformat=unix
set fileformats=unix,dos,mac

" Save undo buffer in undodirectory
" set undofile
" set backupdir
" set viewdir
set swapfile
" set undodir=g:homepath/undodir

" Set spell check
set spell

" Show line number
set number
set relativenumber
set signcolumn=number
set nocursorcolumn
set cursorlineopt=number cursorline
set fillchars=eob:\ ,

" set foldcolumn=1
" set numberwidth=5
set scrolloff=5

" set nowrap
" set linebreak
set sidescroll=1
set sidescrolloff=5

set synmaxcol=512
set regexpengine=1

" Set indent width
" set autoindent " Default on
set shiftwidth=4
" set cindent "Default on
set expandtab " Space
set tabstop=4
" set smarttab
set softtabstop=4 " Space
set shiftround

set list
" set listchars=multispace:\╏\ ,
if has("patch-8.2.5067")
    set listchars=multispace:\╏\ \ \ ,
endif
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
set belloff=all

if $TERM == 'alacritty'
    set ttymouse=sgr
endif

set wildmenu
set wildoptions=pum
set pumheight=10

set complete+=kspell

set hidden
set shortmess=atcs
" autocmd BufEnter * set formatoptions-=cro

set updatetime=500

" Always report number of lines changed
set report=0

let &viminfofile = fnameescape(join([g:_VIM_CACHE_PATH, 'viminfo'], '/'))
set viminfo=%,'999,/999,:999,<999999,@999,c,f1,s1024,

" ------------------------------------------------------------------------------
" Timeout time
" ------------------------------------------------------------------------------
" set timeout " Default on
set timeoutlen=500
set ttimeout
" https://unix.stackexchange.com/questions/9605/how-can-i-detect-if-the-shell-is-controlled-from-ssh
if !empty($TMUX) " In TMUX
    set ttimeoutlen=5
elseif !empty($SSH_CLIENT) || !empty($SSH_TTY) " Not in TMUX but in SSH
    set ttimeoutlen=30
else " Not in TMUX and not in SSH
    set ttimeoutlen=5
endif


" ------------------------------------------------------------------------------
" DiffOrig
" ------------------------------------------------------------------------------
command DiffOrig vert new | set buftype=nofile | r ++edit # | 0d_
    \ | diffthis | wincmd p | diffthis


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
" Remove trailing space and line
" https://stackoverflow.com/questions/7495932/how-can-i-trim-blank-lines-at-the-end-of-file-in-vim
" ------------------------------------------------------------------------------
augroup auto_remove_trailing_spaces_and_lines
    autocmd!
    autocmd BufWritePre
        \ * let b:last_pos = [line('.'), col('.')]
        \ | silent %s/\s\+$//e
        \ | call <SID>remove_trailing_lines()
        \ | call cursor(b:last_pos)
        \ | unlet b:last_pos
augroup END


function s:remove_trailing_lines()
    let l:first_line = line('^')
    let l:first_non_blank_line = nextnonblank(l:first_line)
    if l:first_non_blank_line - 1 >= l:first_line + 1
        call deletebufline('%', l:first_line + 1, l:first_non_blank_line - 1)
    endif
    let l:last_line = line('$')
    let l:last_non_blank_line = prevnonblank(l:last_line)
    if l:last_non_blank_line + 1 <= l:last_line
        call deletebufline('%', l:last_non_blank_line + 1, l:last_line)
    endif
endfunction


" augroup auto_retab
"     autocmd!
"     auto BufReadPost
"                 \ * if &modifiable
"                 \ | retab
"     "             \ | exe "set ul=-1 | e! | set ul=" . &ul
"                 \ | endif
"     auto BufWritePre * set expandtab | retab!
"     auto BufWritePost * set noexpandtab | retab!
" augroup END
