vim9script

const default_IM = 'com.apple.keylayout.ABC'
const selector = 'macism'
var previous_IM = default_IM

def ErrCallback(channel: channel, message: string)
    echohl ErrorMsg
    echomsg message
    echohl None
enddef

def OutCallback(channel: channel, message: string)
    var current_IM = message
    if current_IM != default_IM
        Load(default_IM)
    endif
    previous_IM = current_IM
enddef

def Load(IM: string)
    var cmd =
    [
        selector,
        IM,
    ]
    var callback =
    {
        'err_cb': ErrCallback,
    }
    var job = job_start(cmd, callback)
enddef

export def SaveIM()
    var callback =
    {
        'err_cb': ErrCallback,
        'out_cb': OutCallback,
    }
    var job = job_start([selector], callback)
enddef

export def LoadIM()
    if previous_IM != default_IM
        Load(previous_IM)
    endif
enddef
