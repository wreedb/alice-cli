# utility functions for my color palette

esc = "\x1B["            # begin ansi escape sequence
fg = "%s38;2;" % (esc)   # escape for rgb as foreground
bg = "%s48;2;" % (esc)   # escape for rgb as background
reset = "%s0m" % (esc)   # remove all formatting

# @Param: arr = list of 3 integers; representing rgb
# @Return: string; common "rgb(x,x,x)" format
def string_format_rgb(arr):
  return "rgb(%i, %i, %i)" % (arr[0], arr[1], arr[2]) 

# @Param: arr = list of 3 integers; representing rgb
# @Return: string; "\x1B[38;2;x;y;z;mexample\x1B[0m"
def preview_color(arr):
  ansi_rgb = "%i;%i;%i;m" % (arr[0], arr[1], arr[2])
  return "%s%sexample%s " % (fg, ansi_rgb, reset)

# @Param: scheme = dict; palette variant p.normal||p.bright["rgb"]
# @Param: preview = bool; use preview (true,false)
# @Param: preview_scheme: same as scheme, but only ["rgb"]
# @Return: result = string; representation of rgb scheme
def get_rgb_scheme(scheme, preview, preview_scheme):
  result = ""
  length = len(scheme)
  index = 0
  
  while index < length:
    
    if preview: # if --preview requested, prepend
      result += preview_color(preview_scheme[index])
    
    # concat current index's rgb list to string for display
    # after passed to func for formatting as: "rgb(n, n, n)"
    result += string_format_rgb(scheme[index])
    
    # if NOT last loop iteration; to avoid (extra) trailing newline
    if index != length - 1:
      result += "\n"

    index += 1 # increment
  
  # return display string after full scheme has been iterated over
  return result

# @Param: scheme = dict; palette variant p.normal||p.bright["hex"]
# @Param: preview = bool; use preview (true||false)
# @Param: preview_scheme = dict; rgb variant of dict passed to "scheme" param
# @Return: result = string; reperesentation of hex scheme
def get_hex_scheme(scheme, preview, preview_scheme):
  result = ""
  length = len(scheme)
  index = 0

  while index < length:

    if preview: # if --preview requested, prepend
      result += preview_color(preview_scheme[index])
    
    # concat current scheme index 0-7 to string for for display
    result += scheme[index]

    # if NOT last loop iteration; to avoid (extra) trailing newline
    if index != length - 1:
      result += "\n"
    
    index += 1 # increment
  
  # return display string after full scheme has been iterated over
  return result

# @Param: scheme = dict; palette variant p.normal||p.bright["hex"]
# @Param: index = int; 0-7 for "black"-"white"
# @Param: preview = bool; use preview; true||false
# @Param: preview_scheme = dict; rgb variant of dict passed to "scheme" param
def get_hex_color(scheme, index, preview, preview_scheme):
  
  if preview: # if --preview requested; prepend
    result += preview_color(preview_scheme[index])
  # append the hex code and return it
  result = scheme[index]
  return result

# @Param: scheme = dict; palette variant p.normal||p.bright["rgb"]
# @Param: index = int; 0-7 for "black"-"white"
# @Param: preview = bool; use preview; true||false
# @Param: preview_scheme = dict; rgb color scheme; same as first param
def get_rgb_color(scheme, index, preview, preview_scheme):
  
  if preview: # if --preview requested; prepend it
    result += preview_color(preview_scheme[index])

  # append the normal rgb code and return it
  result = string_format_rgb(scheme[index])
  return result
