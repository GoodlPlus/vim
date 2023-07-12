" ------------------------------------------------------------------------------
" set the cache home path of LeaderF
" ------------------------------------------------------------------------------
let g:Lf_CacheDirectory = g:_VIM_CACHE_PATH

" ------------------------------------------------------------------------------
" LeaderF
" ------------------------------------------------------------------------------
let g:Lf_WindowPosition = 'popup'
" let g:Lf_WindowHeight = 0.2
let g:Lf_DefaultMode = 'FullPath'
let g:Lf_CursorBlink = 0
let g:Lf_WildIgnore =
\ {
    \ 'dir': ['.svn','.git','.hg'],
    \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
\ }
let g:Lf_MruMaxFiles = 999
let g:Lf_DisableStl = 0
" let g:Lf_StlColorscheme = 'gruvbox_material'
let g:Lf_StlSeparator = {'left': '', 'right': ''}
let g:Lf_NormalMap =
\ {
    \ "File": [["<nowait> <ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
    \ "Buffer": [["<nowait> <ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
    \ "Mru": [["<nowait> <ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
    \ "Tag": [["<nowait> <ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
    \ "BufTag": [["<nowait> <ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<CR>']],
    \ "Function": [["<nowait> <ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
    \ "Rg": [["<nowait> <ESC>", ':exec g:Lf_py "rgExplManager.quit()"<CR>']],
    \ "Line": [["<nowait> <ESC>", ':exec g:Lf_py "lineExplManager.quit()"<CR>']],
    \ "Gtags": [["<nowait> <ESC>", ':exec g:Lf_py "gtagsExplManager.quit()"<CR>']],
\ }
let g:Lf_RootMarkers = ['.git', '.hg', '.svn']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_PreviewResult =
\ {
    \ 'File': 0,
    \ 'Buffer': 0,
    \ 'Mru': 0,
    \ 'Tag': 0,
    \ 'BufTag': 0,
    \ 'Function': 0,
    \ 'Line': 0,
    \ 'Colorscheme': 0,
    \ 'Rg': 0,
    \ 'Gtags': 0,
\ }
let g:Lf_HideHelp = 1
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_PreviewInPopup = 1
let g:Lf_PopupPreviewPosition = "top"
" let g:Lf_PreviewHorizontalPosition = 'center'
" let g:Lf_PreviewPopupWidth = &columns
" let g:Lf_PopupHeight = 0.2
let g:Lf_PopupColorscheme = 'gruvbox_material'
let g:Lf_PopupShowFoldcolumn = 0

" nnoremap <Leader>f <Cmd>LeaderfSelf<CR>
nnoremap <Leader>h <Cmd>LeaderfHelp<CR>
nnoremap <Leader>b <Cmd>LeaderfBuffer<CR>
nnoremap <Leader>m <Cmd>LeaderfMru<CR>
nnoremap <Leader>i <Cmd>LeaderfBufTag!<CR>
nnoremap <Leader>I <Cmd>LeaderfBufTagAll!<CR>
nnoremap <Leader>o <Cmd>LeaderfFunction!<CR>
nnoremap <Leader>O <Cmd>LeaderfFunctionAll!<CR>
nnoremap <Leader>/ <Cmd>LeaderfLine<CR>
nnoremap <Leader>? <Cmd>LeaderfLineAll<CR>
nnoremap <Leader>s :Leaderf! rg -e<Space>

" nnoremap <silent><nowait> <Leader>* :<C-u><C-r>=printf('Leaderf! rg --current-buffer -e %s', expand('<cword>'))<CR><CR>
noremap <Leader>* :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR><CR>
" " search visually selected text literally
" xnoremap gf :<C-U><C-R>=printf("Leaderf rg -F -e %s ", leaderf#Rg#visual())<CR>
" xnoremap gf <Cmd>Leaderf rg print<CR>
" noremap go :<C-U>Leaderf! rg --recall<CR>
"
" " should use `Leaderf gtags --update` first
" let g:Lf_GtagsAutoGenerate = 0
" let g:Lf_GtagsAutoUpdate = 1
" let g:Lf_Gtagsconf = '/usr/share/gtags/gtags.conf'
" let g:Lf_Gtagslabel = 'native-pygments'
" nnoremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
" nnoremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
" nnoremap <leader>fg :<C-U><C-R>=printf("Leaderf! gtags -g %s --auto-jump", expand("<cword>"))<CR><CR>
" nnoremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
" nnoremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
" nnoremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
