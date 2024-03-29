#!/bin/sh

BUILDPATH="$(swift build --show-bin-path)"
BINNAME="bitsyspec"
BINDIR=bin

swift build

if [ ! -d "$BINDIR" ]; then
  mkdir "$BINDIR"
fi

cp "$BUILDPATH/$BINNAME" "$BINDIR/"
