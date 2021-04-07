augroup auto_view
	autocmd!
	autocmd BufLeave,VimLeave * call view#save_view()
	autocmd BufEnter * call view#restore_view()
augroup END
