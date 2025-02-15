This is `alice-cli`, a querying tool for my color scheme **Alice**.

## Installation
Python version 3.10 or higher is required.
```sh
# with pipx
pipx install alice-colorscheme
# with pip
python3 -m pip install --user alice-colorscheme
```
## Usage
```sh
# Format options: hex, rgb, hwb or hsl
alice-colorscheme --format hwb
# Scheme defaults to "normal" but can be passed manually for bright palette colors
# For a specific color [black/red/green/yellow/blue/magenta/cyan/white]
alice-colorscheme --scheme bright --format rgb --color green
```

## Roadmap
| Feature              | Status  |
| -------------------- | ------- |
| hex color output     | done    |
| rgb color output     | done    |
| hwb color output     | done    |
| hsl color output     | done    |
| cli color preview    | planned |
| app theme generation | planned |

## Preview
![preview](https://github.com/wreedb/alice-cli/blob/main/assets/preview.png)
