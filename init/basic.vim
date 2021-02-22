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
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,gb18030,big5,euc-jp,latin1
set fileformat=unix
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
set number relativenumber
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
" set noshowmode

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

" Set default grep to rg
set grepprg=rg

set hidden
set shortmess=acs
" set shortmess-=S
" set shortmess+=sc

set updatetime=500
" set pastetoggle=<F12>

" Always report number of lines changed
set report=0


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
" Auto source vimrc
" ------------------------------------------------------------------------------
" autocmd BufWritePost $MYVIMRC source $MYVIMRC


" ------------------------------------------------------------------------------
" Resume edit position
" ------------------------------------------------------------------------------
" Return to last edit position when opening a file
augroup auto_resume_last_position
	autocmd!
	autocmd BufReadPost *
				\ if line("'\"") >= 1 && line("'\"") <= line("$") && &filetype !~# 'commit'
				\ |   execute "normal! g`\""
				\ | endif
augroup END


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
function s:remove_trailing_space()
	let l:last_pos = [line('.'), col('.')]
	silent %s/\s\+$//e
	call cursor(l:last_pos)
endfunction

augroup auto_remove_trailing_space
	autocmd!
	autocmd BufWritePre * call <SID>remove_trailing_space()
augroup END
