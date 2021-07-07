" ------------------------------------------------------------------------------
" vimtex
" ------------------------------------------------------------------------------
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode = 0
let g:tex_conceal = 'abdmg'

let g:vimtex_view_method = "skim"
" let g:vimtex_view_general_viewer = 'skim'
let g:vimtex_view_general_options
	\ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_view_general_options
	\ = '-reuse-instance -forward-search @tex @line @pdf'
	\ . ' -inverse-search "' . exepath(v:progpath)
	\ . ' --servername ' . v:servername
	\ . ' --remote-send \"^<C-\^>^<C-n^>'
	\ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
	\ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
	\ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
