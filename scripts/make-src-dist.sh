#!/bin/sh

version="$(head -n1 $PWD/.repoinfo | cut -d' ' -f2)"

mkdir "alice-${version}-src"
d="alice-${version}-src"

set "Sources" "doc" "scripts" "tests" ".editorconfig" ".repoinfo" "LICENSE.md" "Package.swift" "README.org" "justfile"

for item in $@
do
    cp -arv "${item}" "${d}/${item}"
done

tar -f "${d}.tar" \
    --no-same-owner \
    --no-same-permissions \
    --no-xattrs \
    --no-selinux \
    -v --create "${d}"

gzip --rsyncable --verbose -n "${d}.tar"