// -*- mode: swift; -*- vim:ft=swift


import Foundation
import protocol ArgumentParser.ParsableCommand
import struct ArgumentParser.Flag
import struct ArgumentParser.Option
import struct ArgumentParser.CommandConfiguration

let esc_reset: String = "\u{1B}[0m";
let current_version: String = "0.1.0";

typealias ColorPalette = [(name: String, hex: String, rgb: [Int], hsl: [Int], hwb: [Int])];

// func term_truecolor() -> Bool
// {
//     if let value = ProcessInfo.processInfo.environment["COLORTERM"] {
//         switch value {
//         // Env var is set to 'truecolor'
//         case "truecolor":
//             return(true);
//         // Env var found, but not set to 'truecolor'
//         default:
//             return(false);
//         }
    
//     } else {
//         // Env var isn't set
//         return(false);
//     }
// }

// let is_truecolorterm: Bool = term_truecolor();

let palette_base: ColorPalette = [
    ( /* base: foreground */
        name: "foreground",
        hex: "#EBEBEB",
        rgb: [235, 235, 235],
        hsl: [0, 0, 92],
        hwb: [0, 92, 8]
    ),

    ( /* base: background */
        name: "background",
        hex: "#14161E",
        rgb: [20, 22, 30],
        hsl: [228, 20, 10],
        hwb: [228, 8, 88]
    ),

    ( /* base: selection-foreground */
        name: "selection-foreground",
        hex: "#D7D7D7",
        rgb: [215, 215, 215],
        hsl: [0, 0, 84],
        hwb: [0, 84, 16]
    ),

    ( /* base: selection-background */
        name: "selection-background",
        hex: "#494C59",
        rgb: [73, 76, 89],
        hsl: [229, 10, 32],
        hwb: [229, 29, 65]
    ),

    ( /* base: cursor-foreground */
        name: "cursor-foreground",
        hex: "#1A1D27",
        rgb: [26, 29, 39],
        hsl: [226, 20, 13],
        hwb: [226, 10, 85]
    ),

    ( /* base: cursor-background */
        name: "cursor-background",
        hex: "#80B0E0",
        rgb: [128, 176, 224],
        hsl: [210, 61, 69],
        hwb: [210, 50, 12]
    ),
    
];

let palette_normal: ColorPalette = [

    ( /* normal: black */
        name: "black",
        hex: "#1A1D27",
        rgb: [26, 29, 39],
        hsl: [226, 20, 13],
        hwb: [226, 10, 85]
    ),
  
    ( /* normal: red */
        name: "red",
        hex: "#FB7DA7",
        rgb: [251, 125, 167],
        hsl: [340, 94, 74],
        hwb: [340, 49, 2]
    ),

    ( /* normal: green */
        name: "green",
        hex: "#76C5A4",
        rgb: [118, 197, 164],
        hsl: [155, 41, 62],
        hwb: [155, 46, 23]
    ),

    ( /* normal: yellow */
        name: "yellow",
        hex: "#FDAD5D",
        rgb: [253, 173, 93],
        hsl: [30, 98, 68],
        hwb: [30, 36, 1]
    ),

    ( /* normal: blue */
        name: "blue",
        hex: "#80B0E0",
        rgb: [128, 176, 224],
        hsl: [210, 61, 69],
        hwb: [210, 50, 12]
    ),
    
    ( /* normal: magenta */
        name: "magenta",
        hex: "#AF98E6",
        rgb: [175, 152, 230],
        hsl: [258, 61, 75],
        hwb: [258, 60, 10]
    ),
    
    ( /* normal: cyan */
        name: "cyan",
        hex: "#51C7DA",
        rgb: [81, 199, 218],
        hsl: [188, 65, 59],
        hwb: [188, 32, 15]
    ),

    ( /* normal: white */
        name: "white",
        hex: "#D7D7D7",
        rgb: [235, 235, 235],
        hsl: [0, 0, 92],
        hwb: [0, 84, 16]
    )
  
];

let palette_bright: ColorPalette = [

    ( /* bright: black */
        name: "black",
        hex: "#494C59",
        rgb: [73, 76, 89],
        hsl: [229, 10, 32],
        hwb: [229, 29, 65]
    ),
    
    ( /* bright: red */
        name: "red",
        hex: "#FB83AB",
        rgb: [251, 131, 171],
        hsl: [340, 94, 75],
        hwb: [340, 51, 2]
    ),

    ( /* bright: green */
        name: "green",
        hex: "#7DC8A9",
        rgb: [125, 200, 169],
        hsl: [155, 41, 64],
        hwb: [155, 49, 22]
    ),

    ( /* bright: yellow */
        name: "yellow",
        hex: "#E3CF67",
        rgb: [227, 207, 103],
        hsl: [50, 69, 65],
        hwb: [50, 40, 11]
    ),

    ( /* bright: blue */
        name: "blue",
        hex: "#86B4E2",
        rgb: [134, 180, 226],
        hsl: [210, 61, 71],
        hwb: [210, 53, 11]
    ),
    
    ( /* bright: magenta */
        name: "magenta",
        hex: "#B39DE7",
        rgb: [179, 157, 231],
        hsl: [258, 61, 76],
        hwb: [258, 62, 9]
    ),
    
    ( /* bright: cyan */
        name: "cyan",
        hex: "#5ACADC",
        rgb: [90, 202, 220],
        hsl: [188, 65, 61],
        hwb: [188, 35, 14]
    ),

    ( /* bright: white */
        name: "white",
        hex: "#ECECEC",
        rgb: [236, 236, 236],
        hsl: [0, 0, 93],
        hwb: [0, 93, 7]
    )

];

func name_to_index_base(name: String) -> Int {
    var color_index: Int = 99;
    switch name {
    case "foreground":
        color_index = 0;
    case "fg":
        color_index = 0;

    case "background":
        color_index = 1
    case "bg":
        color_index = 1;
        
    case "selection-foreground":
        color_index = 2;
    case "sel-fg":
        color_index = 2;
    
    case "selection-background":
        color_index = 3;
    case "sel-bg":
        color_index = 3
        
    case "cursor-foreground":
        color_index = 4;
    case "cursor-fg":
        color_index = 4;

    case "cursor-background":
        color_index = 5;
    case "cursor-bg":
        color_index = 5;
        
    case " ":
        fatal_print(msg: "no color name provided, see --help for more information", exitcode: 1)
    default:
        fatal_print(msg: "color '\(name)' is not a part of the base scheme, see --help/--help-colors for more information", exitcode: 1)
    }

    return(color_index);

}

func name_to_index(name: String) -> Int {
    var color_index: Int = 99;
    switch name {
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
    case " ":
        fatal_print(msg: "no color name provided, see --help for more information", exitcode: 1)
    default:
        fatal_print(msg: "color '\(name)' is not recognized, see --help for more information", exitcode: 1)
    }

    return(color_index);
}

func get_single_color(verbose: Bool, preview: Bool, fmt: String, name: String, palName: String, palette: ColorPalette) -> String
{
    var color_index: Int = 99;
    switch palName {
    case "base":
        color_index = name_to_index_base(name: name);
    case "normal":
        color_index = name_to_index(name: name);
    case "bright":
        color_index = name_to_index(name: name);
    default:
        fatal_print(msg: "scheme \(palName) is not recognized, see --help for more information", exitcode: 1);
    }

    let color = palette[color_index];
    var output_str: String = verbose ? "\(color.name): " : "";

    if preview {
        let rgb_arr: [Int] = color.rgb;
        let esc_strings: (fg: String, bg: String) = gen_color_preview(rgb: rgb_arr);
        output_str += "\(esc_strings.fg)"
    }
    
    switch fmt {
    case "hex":
        output_str += "\(color.hex)";
    case "rgb":
        output_str += "rgb(\(color.rgb[0]), \(color.rgb[1]), \(color.rgb[2]))";
    case "hsl":
        output_str += "hsl(\(color.hsl[0])deg \(color.hsl[1])% \(color.hsl[2])%)";
    case "hwb":
        output_str += "hwb(\(color.hwb[0])deg \(color.hwb[1])% \(color.hwb[2])%)";
    default:
        print("error, format: \(fmt); is NOT a valid argument to get_single_color");
        exit(1);
    }
    if preview {
        output_str += "\(esc_reset)";
    }

    return(output_str);
}

func palette_to_arr_hex(verbose: Bool, preview: Bool, palette: ColorPalette) -> [String] {
    var hex_arr: [String] = [String]();

    
    for tuple in palette {
        // yeah, its a ternary.
        // if the functions 'verbose' param is true, it just prepends the color name to each string. thats it
        var append_str: String = verbose ? "\(tuple.name): " : "";

        if preview {
            let rgb_arr: [Int] = tuple.rgb;
            let esc_strings: (fg: String, bg: String) = gen_color_preview(rgb: rgb_arr);
            append_str += "\(esc_strings.fg)\(tuple.hex)\(esc_reset)";
        }
        else { append_str += "\(tuple.hex)"; }
        
        hex_arr.append(append_str);
    }
    return(hex_arr);
}

func palette_to_arr_rgb(verbose: Bool, preview: Bool, palette: ColorPalette) -> [String]
{
    var rgb_array: [String] = [String]();
    
    for tuple in palette {
        // yeah, its a ternary.
        // if the functions 'verbose' param is true, it just prepends the color name to each string. thats it
        var append_str: String = verbose ? "\(tuple.name): " : "";
        if preview {
            let rgb_arr: [Int] = tuple.rgb;
            let esc_strings: (fg: String, bg: String) = gen_color_preview(rgb: rgb_arr);

            append_str += "\(esc_strings.fg)";
            append_str += "rgb(\(tuple.rgb[0]), \(tuple.rgb[1]), \(tuple.rgb[2]))";
            append_str += "\(esc_reset)";
        }
        else
        {
            append_str += "rgb(\(tuple.rgb[0]), \(tuple.rgb[1]), \(tuple.rgb[2]))";
        }
        
        rgb_array.append(append_str);
    }
    return(rgb_array);
}

func palette_to_arr_hslhwb(fmt: String, verbose: Bool, preview: Bool, palette: ColorPalette) -> [String]
{
    var hslhwb_array: [String] = [String]();
    
    switch fmt {
    case "hsl":
        for tuple in palette {
            // yeah, its a ternary.
            // if the functions 'verbose' param is true, it just prepends the color name to each string. thats it
            var append_str: String = verbose ? "\(tuple.name): " : "";
            
            if preview
            {
                let rgb_arr: [Int] = tuple.rgb;
                let esc_strings: (fg: String, bg: String) = gen_color_preview(rgb: rgb_arr);
                
                append_str += "\(esc_strings.fg)";
                append_str += "hsl(\(tuple.hsl[0])deg \(tuple.hsl[1])% \(tuple.hsl[2])%)";
                append_str += "\(esc_reset)";
            }
            else
            {
                append_str += "hsl(\(tuple.hsl[0])deg \(tuple.hsl[1])% \(tuple.hsl[2])%)";
            }
            
            hslhwb_array.append(append_str);

        }

    case "hwb":
        for tuple in palette {
            var append_str: String = verbose ? "\(tuple.name): " : "";

            if preview
            {
                let rgb_arr: [Int] = tuple.rgb;
                let esc_strings: (fg: String, bg: String) = gen_color_preview(rgb: rgb_arr);
                
                append_str += "\(esc_strings.fg)";
                append_str += "hwb(\(tuple.hwb[0])deg \(tuple.hwb[1])% \(tuple.hwb[2])%)";
                append_str += "\(esc_reset)";
            }
            else
            {
                append_str += "hwb(\(tuple.hwb[0])deg \(tuple.hwb[1])% \(tuple.hwb[2])%)";
            }
            
            hslhwb_array.append(append_str);
        }

    default:
        print("internal error: \(fmt) argument not recognized");
        exit(1);
    }

    return(hslhwb_array);
}

func format_full_output(colors: [String]) -> String
{
    var output_string: String = "";
    var index: Int = 1;
    for i in colors {
        switch index {
        case colors.count:
            output_string += "\(i)";
        default:
            output_string += "\(i)\n";
        }
        index += 1;
    }
    return(output_string);
}

func gen_color_preview(rgb: [Int]) -> (fg: String, bg: String)
{
    let ansi_fg: String = "\u{1B}[38;2;";
    let ansi_bg: String = "\u{1B}[48;2;";

    var prev_strings: (fg: String, bg: String);

    prev_strings.fg = "\(ansi_fg)\(rgb[0]);\(rgb[1]);\(rgb[2])m";
    prev_strings.bg = "\(ansi_bg)\(rgb[0]);\(rgb[1]);\(rgb[2])m";
    return(prev_strings);
}

func determine_scheme(name: String) -> ColorPalette
{
    var scheme: ColorPalette = ColorPalette();
    switch name {
    case "normal":
        scheme = palette_normal;
    case "bright":
        scheme = palette_bright;
    case "base":
        scheme = palette_base;
    default:
        fatal_print(msg: "Scheme '\(name)' is not recognized, see --help for more information", exitcode: 1);
    }
    return(scheme);
}

func determine_format(fmt: String) -> String
{
    var return_fmt: String = ""
    switch fmt {
    case "hex":
        return_fmt = fmt;
    case "rgb":
        return_fmt = fmt;
    case "hsl":
        return_fmt = fmt;
    case "hwb":
        return_fmt = fmt;
    case "":
        fatal_print(msg: "No format requested, see --help for more information", exitcode: 1);
    default:
        fatal_print(msg: "format '\(fmt)' is not recognized, see --help for more information", exitcode: 1);
    }

    return(return_fmt);
}

func determine_color(color: String) -> Int
{
    return(name_to_index(name: color));
}

func usage_version()
{
    print("Alice: Version \(current_version)");
    exit(0);
}

func action_print(out: String)
{
    print("\(out)");
    exit(0);
}

func fatal_print(msg: String, exitcode: Int32)
{
    print("[\u{1B}[1;31mERROR\u{1B}[0m]: \(msg)");
    exit(exitcode);
}

func help_colorNames()
{
    let msg: String = """
    The --color flag handles different choices depending on the
    color scheme provided to --scheme

    When scheme provided is 'normal' or 'bright',
    available options are:
    - black
    - red
    - green
    - yellow
    - blue
    - magenta
    - cyan
    - white

    When scheme provided is 'base',
    available options are:
    - foreground
    - background
    - selection-foreground
    - selection-background
    - cursor-foreground
    - cursor-background
    """;
    print(msg);
    exit(0);
}

@main
struct Alice: ParsableCommand
{
    static let configuration = CommandConfiguration(
        abstract: "Query for colors from the Alice color scheme"
    );
    
    @Option(
        name: [.short, .customLong("scheme")],
        help: "palette variant to use: normal,bright,base"
    )
    var schemeVariant: String = "normal";

    @Option(
        name: [.short, .customLong("format")],
        help: "output format to use: hex,rgb,hsl,hwb"
    )
    var formatType: String = "";
    
    @Option(
        name: [.short, .customLong("color")],
        help: "Specify one color to display, see --help-colors for available options"
    )
    var colorName: String = "";

    
    @Flag(
        name: [.customShort("p"), .customLong("preview")],
        help: "display color previews along with commands, requires a true-color terminal"
    )
    var usePreview: Bool = false;

    @Flag(
        name: [.customShort("v"), .customLong("verbose")],
        help: "show more verbose output"
    )
    var useVerbose: Bool = false;

    @Flag(
        name: [.customShort("V"), .customLong("version")],
        help: "show version number information and exit"
    )
    var showVersion: Bool = false;

    @Flag(
        name: [.customShort("H"), .customLong("help-colors")],
        help: "Show information about --color flag options"
    )
    var helpColorNames: Bool = false;
    
    mutating func run() throws {
        if helpColorNames {
            help_colorNames();
        }
        
        let singleColor: Bool = (colorName == "") ? false : true;

        let plt = determine_scheme(name: schemeVariant);
        let fmt: String = determine_format(fmt: formatType);

        
        if singleColor
        {
            
            let color: String = get_single_color(verbose: useVerbose, preview: usePreview, fmt: fmt, name: colorName, palName: schemeVariant, palette: plt);
            action_print(out: color);
        }
        
        else
        {
            var full_colors: String = "";

            switch fmt {
            case "hex":
                full_colors = format_full_output(colors: palette_to_arr_hex(verbose: useVerbose, preview: usePreview, palette: plt));
            case "rgb":
                full_colors = format_full_output(colors: palette_to_arr_rgb(verbose: useVerbose, preview: usePreview, palette: plt));
            case "hsl":
                full_colors = format_full_output(colors: palette_to_arr_hslhwb(fmt: "hsl", verbose: useVerbose, preview: usePreview, palette: plt));
            case "hwb":
                full_colors = format_full_output(colors: palette_to_arr_hslhwb(fmt: "hwb", verbose: useVerbose, preview: usePreview, palette: plt));
            default:
                fatal_print(msg: "This code should be unreachable, please file an issue.", exitcode: 1);
            }

            action_print(out: full_colors);
        }
    }
}
