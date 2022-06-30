" ------------------------------------------------------------------------------
" Command
" ------------------------------------------------------------------------------
command -nargs=+ Plugin call plugin#plugin(<args>)
command InstallPlugin call plugin#install_plugin_all()
command UninstallPlugin call plugin#uninstall_plugin_all()
command UpdatePlugin call plugin#update_plugin_all()

Plugin 'keymap'
Plugin 'theme'
Plugin 'matchit'

" Plugin 'https://github.com/Yggdroot/indentLine'
" Plugin 'https://github.com/morhetz/gruvbox'
Plugin 'https://github.com/sainnhe/gruvbox-material'
Plugin 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}
Plugin 'https://github.com/Yggdroot/LeaderF', {'cmd': 'LeaderfInstallCExtension'}
" Plugin 'https://github.com/tamago324/LeaderF-filer'
Plugin 'https://github.com/lervag/vimtex'
Plugin 'https://github.com/honza/vim-snippets'
Plugin 'https://github.com/vim-python/python-syntax'
Plugin 'https://github.com/skywind3000/vim-quickui'

Plugin 'translator'
Plugin 'view'
Plugin 'sync'
Plugin 'format'

call plugin#load_plugin_all()
