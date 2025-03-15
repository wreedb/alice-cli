buildcmd := "swift build --jobs 12"
swiftc_args_opt := "-Xswiftc -gnone -Xswiftc -O"
dynamicflags := "-c release --static-swift-stdlib"
staticflags := "-c release --static-swift-stdlib --swift-sdk x86_64-swift-linux-musl"

default: build

build:
	@echo "Building in debug mode..."
	{{buildcmd}}

release: fetch
	@echo "Building in release mode..."
	{{buildcmd}} {{dynamicflags}}

release-musl: fetch
    @echo "Building statically linked binary in release mode..."
    {{buildcmd}} {{staticflags}}

fetch:
	@echo "Fetching project dependencies..."
	swift package update

strip: release
	@echo "Stripping binary"
	cp .build/release/alice ./out/dynamic/alice
	llvm-strip ./out/release/alice

strip-musl: release-musl
    @echo "Stripping static binary"
    cp .build/release/alice ./out/release-musl/alice
    llvm-strip --strip-all ./out/release-musl/alice

manual:
	@echo "Generating manual page..."
	swift package plugin generate-manual
	cp .build/plugins/GenerateManual/outputs/alice/alice.1 ./out/manual/alice.1

completions:
    @echo "Generating shell completions..."
    ./out/release/alice --generate-completion-script bash > ./out/completions/alice.bash
    ./out/release/alice --generate-completion-script fish > ./out/completions/alice.fish
    ./out/release/alice --generate-completion-script zsh > ./out/completions/alice.zsh

completions-static:
    @echo "Generating shell completions..."
    ./out/release-musl/alice --generate-completion-script bash > ./out/completions/alice.bash
    ./out/release-musl/alice --generate-completion-script fish > ./out/completions/alice.fish
    ./out/release-musl/alice --generate-completion-script zsh > ./out/completions/alice.zsh

test:
	fd . tests --extension sh | cut -d'/' -f2 | cut -d'.' -f1 | fzf | perl -pe 's|$|.sh|; s|^|tests/|' | xargs -r bash

dist: fetch
	@echo "preparing distributable archive..."
	{{buildcmd}} {{dynamicflags}} {{swiftc_args_opt}}
	-rm -rf dist
	mkdir dist
	mkdir dist/completions
	cp .build/release/alice dist/alice
	llvm-strip dist/alice
	./dist/alice --generate-completion-script bash > dist/completions/alice
	./dist/alice --generate-completion-script fish > dist/completions/alice.fish
	./dist/alice --generate-completion-script zsh > dist/completions/_alice
	swift package plugin generate-manual
	cp .build/plugins/GenerateManual/outputs/alice/alice.1 ./dist/alice.1
	cp LICENSE.org dist/LICENSE.org
	tar -f alice-0.1.0-amd64.tar -vc dist/alice dist/alice.1 dist/completions dist/LICENSE.org
	-rm alice-0.1.0-amd64.tar.gz
	pigz -vRp 12 alice-0.1.0-amd64.tar

dist-static: fetch
	@echo "preparing distributable archive (musl)..."
	{{buildcmd}} {{staticflags}} {{swiftc_args_opt}}
	-rm -rf dist-musl
	mkdir dist-musl
	mkdir dist-musl/completions
	cp .build/release/alice dist-musl/alice
	llvm-strip dist-musl/alice
	./dist-musl/alice --generate-completion-script bash > dist-musl/completions/alice
	./dist-musl/alice --generate-completion-script fish > dist-musl/completions/alice.fish
	./dist-musl/alice --generate-completion-script zsh > dist-musl/completions/_alice
	swift package plugin generate-manual
	cp .build/plugins/GenerateManual/outputs/alice/alice.1 ./dist-musl/alice.1
	cp LICENSE.org dist-musl/LICENSE.org
	tar -f alice-0.1.0-amd64-musl.tar -vc dist-musl/LICENSE.org dist-musl/alice dist-musl/alice.1 dist-musl/completions
	-rm alice-0.1.0-amd64-musl.tar.gz
	pigz -vRp 12 alice-0.1.0-amd64-musl.tar

clean:
	swift package purge-cache
	rm -rf .build