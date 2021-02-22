" ------------------------------------------------------------------------------
" vimtex
" ------------------------------------------------------------------------------
let g:vimtex_compiler_latexmk =
\ {
	\ 'build_dir': '',
	\ 'callback': 1,
	\ 'continuous': 1,
	\ 'executable': 'latexmk',
	\ 'hooks': [],
	\ 'options':
	\ [
		\ '-pdflatex',
		\ '-verbose',
		\ '-file-line-error',
		\ '-synctex=1',
		\ '-interaction=nonstopmode',
	\ ],
\ }
let g:tex_flavor = "latex"
let g:vimtex_compiler_progname = "nvr"
let g:vimtex_view_method = "zathura"
let g:vimtex_quickfix_mode = 0
let g:tex_conceal = "abdmg"
