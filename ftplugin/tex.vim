if has('client-server') && empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif
