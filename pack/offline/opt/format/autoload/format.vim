vim9script

# https://hzhu212.github.io/posts/2c63bd16/
const style = join([fnameescape(expand('<sfile>:p:h')), '../utils/.clang-format'], '/')
const visual_mode = {'v': 0, 'V': 0, "\<Ctrl-v>": 0}
var format_info = {}
var channel_to_buffer = {}
var filetype_to_format =
{
    'c': {'format': 'clang-format'},
    'cpp': {'format': 'clang-format'},
    'h': {'format': 'clang-format'},
    'hpp': {'format': 'clang-format'},
    'python': {'format': ['black', 'isort'], 'visual_mode': v:false},
}

# Error!
def Pos2Byte(row: number, col: number): number
    return line2byte(row) + col - 1
enddef

def StartJob(buffer_name: string, cmd: list<any>)
    var callback =
    {
        'err_cb': ErrCallback,
        'close_cb': CloseCallback,
        'exit_cb': ExitCallback,
        'in_io': 'buffer',
        'in_name': buffer_name,
    }
    var job = job_start(cmd, callback)
    var job_info = job_info(job)
    var channel = job_getchannel(job)
    var channel_info = ch_info(channel)
    var channel_id = channel_info['id']
    channel_to_buffer[channel_id] = buffer_name
enddef

def ErrCallback(channel: channel, message: string)
    var channel_info = ch_info(channel)
    var channel_id = channel_info['id']
    var buffer_name = channel_to_buffer[channel_id]
    var buffer_info = format_info[buffer_name]
    var info = buffer_info[-1]
    info['status'] = v:false
    echohl ErrorMsg
    echomsg message
    echohl None
enddef

def CloseCallback(channel: channel)
    var channel_info = ch_info(channel)
    var channel_id = channel_info['id']
    var buffer_name = channel_to_buffer[channel_id]
    var buffer_info = format_info[buffer_name]
    var info = buffer_info[-1]
    if info['status']
        var formatted_lines: list<string>
        while ch_status(channel, {'part': 'out'}) == 'buffered'
            add(formatted_lines, ch_read(channel, {'part': 'out'}))
        endwhile
        if info['format'] == 'clang-format'
            var header = formatted_lines[0]
            var header_dict = json_decode(header)
            info['formatted_byte'] = header_dict["Cursor"]
            formatted_lines = formatted_lines[1 :]
        endif
        OverwriteAllLines(info, formatted_lines)
    endif
enddef

def ExitCallback(job: job, ret: number)
    var job_info = job_info(job)
    var channel = job_getchannel(job)
    var channel_info = ch_info(channel)
    var channel_id = channel_info['id']
    var buffer_name = channel_to_buffer[channel_id]
    var buffer_info = format_info[buffer_name]
    var info = buffer_info[-1]
    var mode = info['mode']
    var start_time = info['start_time']
    info['format_time'] = split(reltimestr(reltime(start_time)))[0]
    var full_file_name = fnamemodify(buffer_name, ':~')
    var formats = info['formats']
    var echo_message: string

    if ret == 0 && len(formats) > 0
        GoFormat(buffer_name, formats)
        return
    else
        if ret == 0
            echo_message = 'Successfully Format '
            echohl SuccessMsg
        else
            echo_message = 'Failed to Format '
            echohl ErrorMsg
        endif
        echo_message ..= full_file_name .. ' =>'
        for i in range(len(buffer_info))
            var _info = buffer_info[i]
            echo_message ..= ' ' .. _info['format'] .. ': ' .. _info['format_time'] .. 's'
        endfor
        echo echo_message
        echohl None
    endif

    if mode == 'n'
        GoBackCursor(info)
    elseif has_key(visual_mode, mode)
        SelectFormattedLines(info)
    endif
    Clean(channel_id, format_info, channel_to_buffer)
enddef

def GoBackCursor(info: dict<any>)
    var buffer_name = info['buffer_name']
    if buffer_name == bufname('%')
        if info['format'] == 'clang'
            execute 'goto ' .. info['formatted_byte']
        endif
    endif
enddef

def SelectFormattedLines(info: dict<any>)
    if !has_key(visual_mode, info['mode'])
        return
    endif
    var buffer_name = info['buffer_name']
    var start_line = info['start_line']
    var end_line = info['end_line']
    var formatted_end_line = info['formatted_end_line']
    if buffer_name == bufname('%')
        execute "normal! \<Esc>"
        if !info['reverse']
            cursor(start_line, 0)
            normal! V
            cursor(formatted_end_line, v:maxcol)
        else
            cursor(formatted_end_line, 0)
            normal! V
            cursor(start_line, v:maxcol)
        endif
    endif
enddef

export def Format()
    var buffer_name = bufname('%')
    var filetype = getbufvar(buffer_name, '&filetype')
    var mode = mode()

    if !has_key(filetype_to_format, filetype)
        return
    elseif has_key(format_info, buffer_name)
        return
    endif

    var format_dict = deepcopy(filetype_to_format[filetype])
    if has_key(visual_mode, mode) && has_key(format_dict, 'visual_mode') && !format_dict['visual_mode']
        return
    endif

    var format = format_dict['format']
    var formats: any
    if type(format) == v:t_string
        formats = [format]
    elseif type(format) == v:t_list
        formats = format
    else
        return
    endif

    GoFormat(buffer_name, formats)
enddef

def GoFormat(buffer_name: string, formats: list<string>)
    var info: dict<any>
    var cmd: list<any>
    var format = remove(formats, 0)

    info['format'] = format
    info['formats'] = formats
    if has_key(format_info, buffer_name)
        add(format_info[buffer_name], info)
    else
        var current_buffer_id = bufnr('%')
        var buffer_id = bufnr(buffer_name)
        execute 'buffer ' .. buffer_id
        retab
        execute 'buffer ' .. current_buffer_id
        format_info[buffer_name] = [info]
    endif

    GetFormatInfo(buffer_name, info)
    if format == 'clang-format'
        GetClangFormatInfo(buffer_name, info)
        cmd = GetClangFormatCmd(info)
    elseif format == 'black'
        GetBlackFormatInfo(buffer_name, info)
        cmd = GetBlackFormatCmd(info)
    elseif format == 'isort'
        GetIsortFormatInfo(buffer_name, info)
        cmd = GetIsortFormatCmd(info)
    endif

    StartJob(buffer_name, cmd)
enddef

def Clean(channel_id: number, _format_info: dict<any>, _channel_to_buffer: dict<any>)
    var buffer_name = _channel_to_buffer[channel_id]
    remove(_format_info, buffer_name)
    remove(_channel_to_buffer, channel_id)
enddef

def OverwriteAllLines(info: dict<any>, formatted_lines: list<string>)
    var buffer_name = info['buffer_name']
    var start_line = info['start_line']
    var end_line = info['end_line']
    var last_line = info['last_line']

    # Add or replace modified lines
    var original_length = last_line
    var formatted_length = len(formatted_lines)
    info['formatted_end_line'] = formatted_length - (last_line - end_line)

    # Search start of the line and end of the line
    var start = 0
    var i = 1
    while i <= end_line && getbufline(buffer_name, i)[0] == formatted_lines[start]
        ++i
        ++start
    endwhile
    var end = formatted_length - 1
    i = original_length
    while i >= start_line && getbufline(buffer_name, i)[0] == formatted_lines[end]
        --i
        --end
    endwhile
    var original_end = i - 1

    if start > end
        return
    endif

    for j in range(start, end)
        if j > original_end
            appendbufline(buffer_name, j, formatted_lines[j])
        else
            setbufline(buffer_name, j + 1, formatted_lines[j])
        endif
    endfor

    if end + 2 <= original_end + 1
        deletebufline('%', end + 2, original_end + 1)
    endif
enddef

def GetFormatInfo(buffer_name: string, info: dict<any>)
    info['start_time'] = reltime()
    info['buffer_name'] = buffer_name
    info['file_name'] = fnamemodify(buffer_name, ':t')
    info['mode'] = mode()
    info['last_line'] = line('$')
    info['cursor'] = getcurpos(bufwinid(buffer_name))
    info['status'] = v:true
    if info['mode'] == 'n'
        info['start_line'] = 1
        info['end_line'] = line('$')
    elseif has_key(visual_mode, info['mode'])
        if line('.') > line('v')
            info['reverse'] = v:false
        elseif line('.') < line('v')
            info['reverse'] = v:true
        elseif col('.') > col('v')
            info['reverse'] = v:false
        elseif col('.') < col('v')
            info['reverse'] = v:true
        else
            info['reverse'] = v:false
        endif
        info['start_line'] = min([line('v'), line('.')])
        info['end_line'] = max([line('v'), line('.')])
    endif
enddef

def GetClangFormatInfo(buffer_name: string, info: dict<any>)
    var cursor = info['cursor']
    info['index'] = 0
    info['original_byte'] = Pos2Byte(cursor[1], cursor[2])
enddef

def GetClangFormatCmd(info: dict<any>): list<any>
    var cmd =
    [
        'clang-format',
        '-style=file:' .. style,
        # '-style="{BasedOnStyle: llvm, IndentWidth: 4, BreakBeforeBraces: Allman, ColumnLimit: 88}"'
        '--lines=' .. info['start_line'] .. ':' .. info['end_line'],
        '--cursor=' .. info['original_byte'],
        '--assume-filename=' .. info['file_name'],
    ]
    return cmd
enddef

def GetBlackFormatInfo(buffer_name: string, info: dict<any>)
    info['index'] = 1
enddef

def GetBlackFormatCmd(info: dict<any>): list<any>
    var cmd =
    [
        'black',
        '-',
        '--line-length=100',
        '--quiet',
    ]
    return cmd
enddef

def GetIsortFormatInfo(buffer_name: string, info: dict<any>)
    info['index'] = 1
enddef

def GetIsortFormatCmd(info: dict<any>): list<any>
    var cmd =
    [
        'isort',
        '-',
        '--profile=black',
        '--quiet',
    ]
    return cmd
enddef
