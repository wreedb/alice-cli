# utility functions for my color palette

# @Param: arr = list of 3 integers; representing rgb
# @Return: string; common "rgb(x,x,x)" format
def string_format_rgb(arr):
    return "rgb(%i, %i, %i)" % (arr[0], arr[1], arr[2])

# @Param: fmt_type = string; "hwb" or "hsl" output formatting
# @Param: arr = list of 3 integers; representing hwb/hsl color
# @Return: string; css-style "hwb/hsl(xdeg x% x%)" format
def string_format_hwb_hsl(fmt_type, arr):
    return "%s(%i%s %i%% %i%%)" % (fmt_type, arr[0], "deg", arr[1], arr[2])

def get_hwb_hsl_scheme(fmt_type, scheme):
    output_str = ""
    len_scheme = len(scheme)
    index = 0

    while index < len_scheme:
        output_str += string_format_hwb_hsl(fmt_type, scheme[index])
        
        # avoid trailing newline
        if index != len_scheme - 1:
            output_str += "\n"
        
        index += 1

    return output_str


# @Param: scheme = dict; palette variant normal/bright["rgb"]
# @Return: string; css-style "rgb(x, x, x)" format
def get_rgb_scheme(scheme):
    output_str = ""
    len_scheme = len(scheme)
    index = 0
    
    while index < len_scheme:
        output_str += string_format_rgb(scheme[index])
        
        # avoid trailing newline
        if index != len_scheme - 1:
            output_str += "\n"
        
        index += 1
    
    # return display string after full scheme has been iterated over
    return output_str


def get_hex_scheme(scheme):
    output_str = ""
    len_scheme = len(scheme)
    index = 0

    while index < len_scheme:
        output_str += scheme[index]

        # avoid trailing newline
        if index != len_scheme - 1:
            output_str += "\n"
        
        index += 1
    
    return output_str


def get_hex_color(scheme, index):
    return scheme[index]

def get_rgb_color(scheme, index):
    return string_format_rgb(scheme[index])

def get_hwb_hsl_color(fmt_type, scheme, index):
    return string_format_hwb_hsl(fmt_type, scheme[index])
