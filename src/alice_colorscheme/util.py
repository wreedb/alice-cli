# utility functions for my color palette

# @Param: arr = list of 3 integers; representing rgb
# @Return: string; common "rgb(x,x,x)" format
def string_format_rgb(arr):
  return "rgb(%i, %i, %i)" % (arr[0], arr[1], arr[2])

def string_format_hsl(arr):
  return "hsl(%i%s %i%% %i%%)" % (arr[0], "deg", arr[1], arr[2])

def get_hsl_scheme(scheme):
  result = ""
  length = len(scheme)
  index = 0

  while index < length:
    result += string_format_hsl(scheme[index])

    if index != length - 1:
      result += "\n"

    index += 1

  return result

# @Param: scheme = dict; palette variant p.normal||p.bright["rgb"]
# @Return: result = string; representation of rgb scheme
def get_rgb_scheme(scheme):
  result = ""
  length = len(scheme)
  index = 0
  
  while index < length:
    # concat current index's rgb list to string for display
    # after passed to func for formatting as: "rgb(n, n, n)"
    result += string_format_rgb(scheme[index])
    
    # if NOT last loop iteration; to avoid (extra) trailing newline
    if index != length - 1:
      result += "\n"

    index += 1
  
  # return display string after full scheme has been iterated over
  return result

# @Param: scheme = dict; palette variant p.normal||p.bright["hex"]
# @Return: result = string; reperesentation of hex scheme
def get_hex_scheme(scheme):
  result = ""
  length = len(scheme)
  index = 0

  while index < length:
    # concat current scheme index to return string
    result += scheme[index]

    # if NOT last loop iteration; to avoid (extra) trailing newline
    if index != length - 1:
      result += "\n"
    
    index += 1
  
  # return display string after full scheme has been iterated over
  return result

# @Param: scheme = dict; palette variant p.normal||p.bright["hex"]
# @Param: index = int; 0-7 for "black"-"white"
def get_hex_color(scheme, index):
  return scheme[index]

def get_rgb_color(scheme, index):
  return string_format_rgb(scheme[index])

def get_hsl_color(scheme, index):
  return string_format_hsl(scheme[index])
