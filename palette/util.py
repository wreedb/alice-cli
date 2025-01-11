# utility functions for my color palette

def string_format_rgb(arr):
    return "rgb(%i, %i, %i)" % (arr[0], arr[1], arr[2]) 

# @Param: scheme = palette variant (normal/bright)
def get_rgb_scheme(scheme):
    result = ""
    length = len(scheme)
    index = 0
    while index < length:
        result = result + string_format_rgb(scheme[index])
        if index != length - 1:
            result += "\n"
        index += 1
    return result

def get_hex_scheme(scheme):
    result = ""
    length = len(scheme)
    index = 0
    while index < length:
        result += scheme[index]
        if index != length - 1:
            result += "\n"
        index += 1
    return result

def get_hex_color(scheme, index):
    return scheme[index]

def get_rgb_color(scheme, index):
    return string_format_rgb(scheme[index])
