
from argparse import ArgumentParser

from alice_colorscheme import palette
from alice_colorscheme import util

def main():

  parser = ArgumentParser(
    prog="alice",
    description="Query info from the alice color scheme",
    epilog="Alice (https://github.com/wreedb/alice-cli)"
  )

  parser.add_argument(
    "-s", "--scheme",
    help="scheme variant to use: [normal (default), bright]"
  )
  parser.add_argument(
    "-f", "--format",
    help="color format to use: [hex, rgb, hsl]",
    required=True
  )

  parser.add_argument(
    "-c","--color",
    help="output a single color: [black,red,green,yellow,blue,magenta,cyan,white]"
  )

  args = parser.parse_args()

  builder = {
    "scheme": "",
    "format": ""
  }

  match args.scheme:
    case "normal":
      builder["scheme"] = "normal"
    case "bright":
      builder["scheme"] = "bright"
    case _:
      print("Invalid argument to -s/--scheme")
      print("Expeceted one of: normal,bright")
      exit(1)

  match args.format:
    case "rgb":
      builder["format"] = "rgb"
    case "hex":
      builder["format"] = "hex"
    case "hsl":
      builder["format"] = "hsl"
    case _:
      print("invalid argument to -f/--format")
      print("expected one of: hex,rgb")
      exit(1)

  if args.color:
    match args.color:
      case "black":
        color_index = 0
      case "red":
        color_index = 1
      case "green":
        color_index = 2
      case "yellow":
        color_index = 3
      case "blue":
        color_index = 4
      case "magenta":
        color_index = 5
      case "cyan":
        color_index = 6
      case "white":
        color_index = 7
      case _:
        print("invalid argument to -c/--color")
        print("expected one of:")
        print("black,red,green,yellow,blue,magenta,cyan,white")
        exit(1)

    match builder["scheme"]:

      case "normal":
        match builder["format"]:
          case "rgb":
            print(util.get_rgb_color(palette.normal["rgb"], color_index))
          case "hex":
            print(util.get_hex_color(palette.normal["hex"], color_index))
          case "hsl":
            print(util.get_hsl_color(palette.normal["hsl"], color_index))
          case _:
            print("Internal error: (format = %s)" % (builder["format"]))
            exit(1)

      case "bright":

        match builder["format"]:
          case "rgb":
            print(util.get_rgb_color(palette.bright["rgb"], color_index))
          case "hex":
            print(util.get_hex_color(palette.bright["hex"], color_index))
          case "hsl":
            print(util.get_hsl_color(palette.bright["hsl"], color_index))
          case _:
            print("Internal error: (format = %s)" % (builder["format"]))
            exit(1)

      case _:
        print("Internal error: (scheme = %s)" % (builder["scheme"]))
        exit(1)

  else:

    match builder["scheme"]:

      case "normal":

        match builder["format"]:
          case "rgb":
            print(util.get_rgb_scheme(palette.normal["rgb"]))
          case "hex":
            print(util.get_hex_scheme(palette.normal["hex"]))
          case "hsl":
            print(util.get_hsl_scheme(palette.normal["hsl"]))
          case _:
            print("Internal error: (format = %s)" % (builder["format"]))
            exit(1)

      case "bright":

        match builder["format"]:
          case "rgb":
            print(util.get_rgb_scheme(palette.bright["rgb"]))
          case "hex":
            print(util.get_hex_scheme(palette.bright["hex"]))
          case "hsl":
            print(util.get_hsl_scheme(palette.bright["hsl"]))
          case _:
            print("Internal error: (format = %s)" % (builder["format"]))
            exit(1)


      case _:
        print("Internal error: (scheme = %s)" % (builder["scheme"]))
        exit(1)

if __name__ == "__main__":
  main()
