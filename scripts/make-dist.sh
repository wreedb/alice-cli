#!/bin/sh

version="$(head -n1 $PWD/.repoinfo | cut -d' ' -f2)"

mkdir "alice-${version}"
d="alice-${version}"

binary="./.build/release/alice"

install -Dvm 0644 LICENSE.md "${d}/share/licenses/alice/LICENSE.md"
scdoc < doc/alice.1.scd > doc/alice.1
install -Dvm 0644 doc/alice.1 "${d}/share/man/man1/alice.1"
install -Dvm 0755 "${binary}" "${d}/bin/alice"
strip --strip-all "${d}/bin/alice"
install -vd "${d}/share/bash-completion/completions"
install -vd "${d}/share/fish/vendor_completions.d"
install -vd "${d}/share/zsh/site-functions"
"${d}/bin/alice" --generate-completion-script bash > "${d}/share/bash-completion/completions/alice"
"${d}/bin/alice" --generate-completion-script zsh > "${d}/share/zsh/site-functions/_alice"
"${d}/bin/alice" --generate-completion-script fish > "${d}/share/fish/vendor_completions.d/alice.fish"

tar -f "${d}.tar" \
    --no-same-owner \
    --no-same-permissions \
    --no-xattrs \
    --no-selinux \
    -v --create "${d}"

gzip --rsyncable --verbose -n "${d}.tar"