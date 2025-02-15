# -*- mode: python; -*- vim:ft=python

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
        default = "normal",
        help = "scheme variant to use: [normal (default), bright]"
    )
    
    parser.add_argument(
        "-f", "--format",
        help = "color format to use: [hex, rgb, hwb, hsl]",
        required = True
    )

    parser.add_argument(
        "-c", "--color",
        help = "output a single color: [black,red,green,yellow,blue,magenta,cyan,white]"
    )

    args = parser.parse_args()

    user_options = {
        "scheme": "",
        "format": ""
    }

    match args.scheme:
        case "normal":
            user_options["scheme"] = "normal"
        case "bright":
            user_options["scheme"] = "bright"
        case _:
            print("Invalid argument to -s/--scheme")
            print("Expeceted one of: normal,bright")
            exit(1)

    match args.format:
        case "rgb":
            user_options["format"] = "rgb"
        case "hex":
            user_options["format"] = "hex"
        case "hwb":
            user_options["format"] = "hwb"
        case "hsl":
            user_options["format"] = "hsl"
        case _:
            print("invalid argument to -f/--format")
            print("expected one of: rgb,hex,hwb,hsl")
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

        match user_options["scheme"]:

            case "normal":
                match user_options["format"]:
                    case "rgb":
                        print(util.get_rgb_color(palette.normal["rgb"], color_index))
                    case "hex":
                        print(util.get_hex_color(palette.normal["hex"], color_index))
                    case "hwb":
                        print(util.get_hwb_hsl_color("hwb", palette.normal["hwb"], color_index))
                    case "hsl":
                        print(util.get_hwb_hsl_color("hsl", palette.normal["hsl"], color_index))

            case "bright":
                match user_options["format"]:
                    case "rgb":
                        print(util.get_rgb_color(palette.bright["rgb"], color_index))
                    case "hex":
                        print(util.get_hex_color(palette.bright["hex"], color_index))
                    case "hwb":
                        print(util.get_hwb_hsl_color("hwb", palette.bright["hwb"], color_index))
                    case "hsl":
                        print(util.get_hwb_hsl_color("hsl", palette.bright["hsl"], color_index))

    else: # user did not request a specific color

        match user_options["scheme"]:
            
            case "normal":
                match user_options["format"]:
                    case "rgb":
                        print(util.get_rgb_scheme(palette.normal["rgb"]))
                    case "hex":
                        print(util.get_hex_scheme(palette.normal["hex"]))
                    case "hwb":
                        print(util.get_hwb_hsl_scheme("hwb", palette.normal["hwb"]))
                    case "hsl":
                        print(util.get_hwb_hsl_scheme("hsl", palette.normal["hsl"]))

            case "bright":
                match user_options["format"]:
                    case "rgb":
                        print(util.get_rgb_scheme(palette.bright["rgb"]))
                    case "hex":
                        print(util.get_hex_scheme(palette.bright["hex"]))
                    case "hwb":
                        print(util.get_hwb_hsl_scheme("hwb", palette.bright["hwb"]))
                    case "hsl":
                        print(util.get_hwb_hsl_scheme("hsl", palette.bright["hsl"]))


if __name__ == "__main__":
    main()
