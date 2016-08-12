# Bitsy

[Bitsy](BITSY.md) aims to be the best language to target when building your
first compiler or interpreter.

 * Read more about the Bitsy language: [BITSY](BITSY.md)
 * See the canonical implementation: [bitys-swift](https://github.com/apbendi/bitsy-swift)

# BitsySpec

BitsySpec aims to codify the definition of Bitsy in a series of tests that can
be run against any Bitsy implementation. BitsySpec consists of two parts:

 1. A command line utility for running test specifications against any
    implementation of Bitsy
 2. A series of "specs", Bitsy programs paired with their expected output,
    to test the correctness of a given Bitsy implementation

## Usage

The command line utility that can be pointed at any `.bitsy` file
or a directory containing multiple `.bitsy` files. Each file is a program written
in the Bitsy language prepended with a code comment in a format which
defines the expected output. The BitsySpec command line utility
runs each program with the implementation of Bitsy provided and validates
the output produced matches that expected.

This repo also contains a collection of specs
in the `/specs` directory. The goal is to for the specs contained there to fully
define a "correct" implementation of Bitsy.
