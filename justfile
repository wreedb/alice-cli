buildcmd := "swift build --jobs 12"
swiftc_args_opt := "-Xswiftc -gnone -Xswiftc -O"
dynamicflags := "-c release --static-swift-stdlib"
staticflags := "-c release --static-swift-stdlib --swift-sdk x86_64-swift-linux-musl"

default:
    @just -l

build:
    @echo -e "\e[1;32m*\e[0m>>> Building in debug mode..."
    {{buildcmd}}

release: fetch
    @echo -e "\e[1;32m*\e[0m>>> Building binary in release mode..."
    {{buildcmd}} {{dynamicflags}} {{swiftc_args_opt}}

release-static: fetch
    @echo -e "\e[1;32m*\e[0m>>> Building static binary in release mode..."
    {{buildcmd}} {{staticflags}} {{swiftc_args_opt}}

fetch:
    @echo -e "\e[1;32m*\e[0m>>> Fetching project dependencies..."
    swift package update

test:
    fd . tests --extension sh | cut -d'/' -f2 | cut -d'.' -f1 | fzf | perl -pe 's|$|.sh|; s|^|tests/|' | xargs -r bash

manual:
    @echo -e "\e[1;32m*\e[0m>>> Building manual with scdoc..."
    scdoc < doc/alice.1.scd > doc/alice.1

dist: clean fetch manual
    @echo -e "\e[1;32m*\e[0m>>> Building release tarball..."
    {{buildcmd}} {{dynamicflags}} {{swiftc_args_opt}}
    mkdir dist dist/completions
    cp .build/release/alice dist/alice
    llvm-strip dist/alice
    ./dist/alice --generate-completion-script bash > dist/completions/alice.bash
    ./dist/alice --generate-completion-script fish > dist/completions/alice.fish
    ./dist/alice --generate-completion-script zsh > dist/completions/alice.zsh
    cp LICENSE.org dist/LICENSE.org
    cp doc/alice.1 dist/alice.1
    tar -f alice-v0.1.0-amd64.tar -vc dist/*
    pigz -Rvp 12 alice-v0.1.0-amd64.tar
 
dist-static: clean fetch manual
    @echo -e "\e[1;32m*\e[0m>>> Building static release tarball..."
    {{buildcmd}} {{staticflags}} {{swiftc_args_opt}}
    mkdir dist-static dist-static/completions
    cp .build/release/alice dist-static/alice
    llvm-strip dist-static/alice
    ./dist-static/alice --generate-completion-script bash > dist-static/completions/alice.bash
    ./dist-static/alice --generate-completion-script fish > dist-static/completions/alice.fish
    ./dist-static/alice --generate-completion-script zsh > dist-static/completions/alice.zsh
    cp LICENSE.org dist-static/LICENSE.org
    cp doc/alice.1 dist-static/alice.1
    tar -f alice-v0.1.0-amd64-static.tar -vc dist-static/*
    pigz -Rvp 12 alice-v0.1.0-amd64-static.tar

clean:
    @echo -e "\e[1;32m*\e[0m>>> Cleaning project..."
    -swift package purge-cache
    -rm -rf .build
    -rm *.tar.gz
    -rm -rf dist dist-static