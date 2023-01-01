vim9script

import autoload '../autoload/IM.vim'

augroup smartim
    autocmd!
    autocmd InsertLeave * IM.SaveIM()
    autocmd InsertEnter * IM.LoadIM()
augroup END
