vim9script

# https://hzhu212.github.io/posts/2c63bd16/
const style = join([fnameescape(expand('<sfile>:p:h')), '../utils/.clang-format'], '/')
const visual_mode = {'V': 0}
var format_info = {}
var channel_to_buffer = {}
var filetype_to_format =
{
    'c': 'clang-format',
    'cpp': 'clang-format',
    'h': 'clang-format',
    'hpp': 'clang-format',
    'python': 'black'
}

# Error!
def Pos2Byte(s: string): number
    return line2byte(line(s)) + col(s) - 1
enddef

def PositionToOffset(buffer_name: string, row: number, col: number): number
    var offset = col - 1 # 1-based to 0-based
    if row > 1
        for i in range(1, row - 1) # 1-based to 0-based, exclude current
            offset += len(getbufline(buffer_name, i)[0]) + 1 # +1 for newline
        endfor
    endif
    return offset
enddef

def StartJob(buffer_name: string, cmd: list<any>)
    var callback =
    {
        'out_cb': OutCallback,
        'err_cb': ErrCallback,
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

def OutCallback(channel: channel, message: string)
    var channel_info = ch_info(channel)
    var channel_id = channel_info['id']
    var buffer_name = channel_to_buffer[channel_id]

    add(format_info[buffer_name]['formatted_lines'], message)
enddef

def ErrCallback(channel: channel, message: string)
    var channel_info = ch_info(channel)
    var channel_id = channel_info['id']
    var buffer_name = channel_to_buffer[channel_id]
    var full_file_name = fnamemodify(buffer_name, ':~')
    echohl ErrorMsg | echomsg 'Failed to Format ' .. full_file_name .. ' => ' .. message

    Clean(channel_id, format_info, channel_to_buffer)
enddef

def ExitCallback(job: job, ret: number)
    var job_info = job_info(job)
    var channel = job_getchannel(job)
    var channel_info = ch_info(channel)
    var channel_id = channel_info['id']
    var buffer_name = channel_to_buffer[channel_id]
    var info = format_info[buffer_name]

    Overwrite(info)

    var start_time = info['start_time']
    var format_time = split(reltimestr(reltime(start_time)))[0]
    var full_file_name = fnamemodify(buffer_name, ':~')
    echohl WarningMsg | echo 'Successfully Format ' .. full_file_name .. ' => ' .. format_time .. 's'

    Clean(channel_id, format_info, channel_to_buffer)
enddef

export def Format()
    var buffer_name = bufname('%')
    var filetype = getbufvar(buffer_name, '&filetype')
    if !has_key(filetype_to_format, filetype)
        return
    endif
    if has_key(format_info, buffer_name)
        return
    endif
    var mode = mode()
    if mode != 'n' && !has_key(visual_mode, mode)
        return
    endif

    var format = filetype_to_format[filetype]

    var info = GetFormatInfo(buffer_name)
    var extra_info: dict<any>
    var cmd: list<any>

    if format == 'clang-format'
        extra_info = GetClangFormatInfo(buffer_name)
        cmd = GetClangFormatCmd(info)
    elseif format == 'black'
        extra_info = GetBlackFormatInfo(buffer_name)
        cmd = GetBlackFormatCmd(info)
    endif

    extend(info, extra_info)

    format_info[buffer_name] = info

    StartJob(buffer_name, cmd)
enddef

def GetFormatInfo(buffer_name: string): dict<any>
    var info: dict<any>
    info['start_time'] = reltime()
    info['formatted_lines'] = []
    info['buffer_name'] = buffer_name
    info['file_name'] = fnamemodify(buffer_name, ':t')
    info['mode'] = mode()
    info['original_pos'] = Pos2Byte('.')
    if info['mode'] == 'n'
        info['start_line'] = 1
        info['end_line'] = line('$')
    elseif has_key(visual_mode, info['mode'])
        info['start_line'] = min([line('v'), line('.')])
        info['end_line'] = max([line('v'), line('.')])
    endif
    return info
enddef

def GetClangFormatInfo(buffer_name: string): dict<any>
    var info: dict<any>
    var current_pos = getcurpos(bufwinid(buffer_name))
    var original_pos = PositionToOffset(buffer_name, current_pos[1], current_pos[2])
    return info
enddef

def GetClangFormatCmd(info: dict<any>): list<any>
    var cmd =
    [
        'clang-format',
        '-style=file:' .. style,
        '--lines=' .. info['start_line'] .. ':' .. info['end_line'],
        '--cursor=' .. info['original_pos'],
        '--assume-filename=' .. info['file_name'],
    ]
    return cmd
enddef

def GetBlackFormatInfo(buffer_name: string): dict<any>
    var info: dict<any>
    return info
enddef

def GetBlackFormatCmd(info: dict<any>): list<any>
    var cmd =
    [
        'black',
        '-',
        '--line-length=88',
        '--quiet',
    ]
    return cmd
enddef

# info['index'] = 0
def Overwrite(info: dict<any>, formatted_line)
    var index = info['index']
    var start_line = info['start_line']
    var end_line = info['end_line']
    var buffer_name = info['buffer_name']
    if index < start_line
        return
    else
        var original_line = getbufline(buffer_name, info['index'])
        if original_line != formatted_line
            setbufline(buffer_name, index, formatted_line)
        endif

        if index
    elseif index > end_line
        appendbufline(buffer_name, index, formatted_line)
    else
        if original_line != formatted_line
            setbufline(buffer_name, index, formatted_line)
        endif
    endif
enddef


def Overwrite(info: dict<any>)
    var buffer_name = info['buffer_name']
    var header = info['formatted_lines'][0]
    var formatted_lines = info['formatted_lines'][1 :]
    # var header_dict = json_decode(header)
    # var current_pos = header_dict["Cursor"]
    var start_line = info['start_line']
    var end_line = info['end_line']

    # Add or replace modified lines
    var original_lines = getbufline(buffer_name, 1, '$')
    var original_length = len(original_lines)
    var formatted_length = len(formatted_lines)

    # Search start of the line and end of the line
    var start = 0
    var i = 0
    while i < end_line && original_lines[i] == formatted_lines[start]
        ++i
        ++start
    endwhile
    var end = formatted_length - 1
    i = original_length - 1
    while i >= start_line - 1 && original_lines[i] == formatted_lines[end]
        --i
        --end
    endwhile
    var original_end = i

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

    # execute 'goto' current_pos
enddef

def Clean(channel_id: number, _format_info: dict<any>, _channel_to_buffer: dict<any>)
    var buffer_name = _channel_to_buffer[channel_id]
    remove(_format_info, buffer_name)
    remove(_channel_to_buffer, channel_id)
enddef

export def SyncClangFormat()
    var mode = mode()
    var start_line = 1
    var end_line = line('$')
    var visual_mode = {'V': 0}
    if has_key(visual_mode, mode)
        start_line = min([line('v'), line('.')])
        end_line = max([line('v'), line('.')])
    elseif mode != 'n'
        return
    endif
    var buffer_name = bufname('%')
    var pos = getcurpos(bufwinid(buffer_name))
    var original_pos = PositionToOffset(buffer_name, pos[1], pos[2])
    var cursor = original_pos

    var cmd = 'clang-format'
    cmd ..= ' -style=file:' .. style .. ' --lines=' .. start_line .. ':' .. end_line .. ' --cursor=' .. cursor .. ' --assume-filename=' .. buffer_name

    var original_lines = getline(1, line('$'))
    var ret = system(cmd, join(original_lines, "\n"))
    var splitted_ret = split(ret, "\n")

    var header = splitted_ret[0]
    var formatted_lines = splitted_ret[1 :]
    var header_dict = json_decode(header)
    var current_pos = header_dict["Cursor"]

    # Add or replace modified lines
    var original_length = len(original_lines)
    var formatted_length = len(formatted_lines)

    # Search start of the line and end of the line
    var start = 0
    var i = 0
    while i < end_line && original_lines[i] == formatted_lines[start]
        ++i
        ++start
    endwhile
    var end = formatted_length - 1
    i = original_length - 1
    while i >= start_line - 1 && original_lines[i] == formatted_lines[end]
        --i
        --end
    endwhile
    var original_end = i

    if start > end
        return
    endif

    for j in range(start, end)
        if j > original_end
            append(j, formatted_lines[j])
        else
            setline(j + 1, formatted_lines[j])
        endif
    endfor

    if end + 2 <= original_end + 1
        deletebufline('%', end + 2, original_end + 1)
    endif

    execute 'goto' current_pos
enddef
