#!/bin/sh

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 BITSY_BINARY" >&2
  exit 1
fi

SPECSUB=specs
BINSUB=build/Debug
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

SPECPATH=$SCRIPTPATH/$SPECPATH
BINPATH=$SCRIPTPATH/$BINSUB/bitsyspec

$BINPATH $1 $SPECPATH
