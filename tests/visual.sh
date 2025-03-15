#!/bin/sh

# DESC: print all color previews for visual review

8colors()
{
	for format in hex rgb hsl hwb
	do
		for scheme in normal bright
		do
			printf '%s\n' "[BEGIN] ${format}:${scheme}"
			for color in black red green yellow blue magenta cyan white
			do
				./alice -s "${scheme}" -f "${format}" -c "${color}" -p
			done
			printf '%s\n\n' "[END] ${format}:${scheme}"
		done
	done
}

bases()
{
	for format in hex rgb hsl hwb
	do
		printf '%s\n' "[BEGIN] ${format}"
		for color in foreground background selection-foreground selection-background cursor-foreground cursor-background fg bg sel-fg sel-bg cursor-fg cursor-bg
		do
			./alice -s base -f "${format}" -c "${color}" -p
		done
		printf '%s\n\n' "[END] ${format}"
	done
}

8colors;
bases;