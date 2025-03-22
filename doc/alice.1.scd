ALICE(1)

# NAME

*alice* a querying tool for the _Alice_ color scheme

# SYNOPSIS

*alice* *-f* <format> [*-s* <scheme>] [*-c* <color>] [*-v*, *-p*]

# DESCRIPTION

*alice* is a CLI tool for retrieving formatted color information++
from the _Alice_ color scheme. It may be use to output an entire++
scheme/palette, or a single color at a time. It also has the ability++
to format output with ANSI (truecolor) escape sequences to preview++
any colors being output.

# OPTIONS

## Formatting

*-f, --format* <format>
	Selects a given format for output, available options are++
_hex_, _rgb_, _hsl_ and _hwb_.

*-p, --preview*
	Output ANSI color previews of each color displayed++
NOTE: requires a truecolor terminal emulator.

## Selection

*-s, --scheme* <name>
	Select a given scheme to operate on, available options are++
	_base_, _bright_ and _normal_ (default).

*-c, --color* <name>
	Select a single color to operate on. Available options are++
dependent on the *scheme* selected. Issuing *-H, --help-colors*++
will output the possible color names for all available schemes.

## Misc.

*-v, --verbose*
	Print the name of each color alongside normal output.

*-h, --help*
	Print usage information.

*-H, --help-colors*
	Print color name options for all available schemes.

# COPYRIGHT
	
	Copyright (C) 2025 Will Reed, License GPLv3+ ++
GNU GPL version 3 or later ++
This is free software: you are free to change and ++
redistribute it. Ther is NO WARRANTY, to the extent ++
permitted by law.

# AUTHOR

	Written by Will Reed <_https://github.com/wreedb_>
