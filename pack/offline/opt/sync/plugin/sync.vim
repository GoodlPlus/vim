command Upload call sync#sync('upload')
command Download call sync#sync('download')
command UploadAll call sync#sync('upload_all')
command DownloadAll call sync#sync('download_all')

augroup auto_sync
	autocmd!
	autocmd BufWritePost * call sync#sync('upload')
	autocmd VimLeave * call sync#sync('upload_all')
augroup END
