#!/bin/sh

BUILDCMD=xcodebuild
BINDIR=bin

$BUILDCMD

if [ ! -d "$BINDIR" ]; then
  mkdir "$BINDIR"
fi

cp build/Release/bitsyspec "$BINDIR/"
