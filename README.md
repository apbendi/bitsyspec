# Bitsy

[Bitsy](BITSY.md) aims to be the best language to target when building your
first compiler or interpreter. It is a resource for programmers learning about
language implementation.

 * Read more about the Bitsy language: [BITSY.md](BITSY.md)
 * See the canonical implementation: [bitsy-swift](https://github.com/apbendi/bitsy-swift)

# BitsySpec

BitsySpec aims to codify the definition of Bitsy in a series of tests that can
be run against any Bitsy implementation. BitsySpec consists of two parts:

 1. A command line utility for running test specifications against any
    implementation of Bitsy
 2. A series of "specs", Bitsy programs paired with their expected output,
    to test the correctness of a given Bitsy implementation

BitsySpec is a useful tool for a first time language implementor.
It provides fast, automated feedback on what works and whats left to do in your
implementation, even enabling a test driven approach if desired.

## Requirements

This version of BitsySpec has been tested with:

 * OS X 10.11 (El Capitan)
 * Xcode 7.3.1
 * Swift 2.2

Xcode 8, macOS Sierra, and Swift 3 support is forthcoming. Linux
support is currently limited by
[Swift Foundation](https://github.com/apple/swift-corelibs-foundation) but
should come eventually.

Swift is an implementation detail of BitsySpec. Your compiler or interpreter
can be in virtually any language.

## Installation

To 'install' BitsySpec, simply clone and build the repository. You must have
Xcode and the `xcodebuild` utility installed.

```bash
git clone https://github.com/apbendi/bitsyspec.git
cd bitsyspec
./build.sh
```

## Usage

The `runspecs` scripts can be used to conveniently run all [specs included
in this repo](specs) with a provided implementation of Bitsy.

```bash
 ./runspecs path/to/my-bitsy
 ✅  Add Integer literals
 ✅  Allow for variable assignment and use
 ✅  Divide Integer literals
 ✅  Calculate the factorial of a number
 ✅  Calculate the first 10 numbers in the fibonacci sequence
 ✅  Branch on negative values with IFN
 ✅  Branch to ELSE on non-negative values with IFN
 ✅  Handle nested branching with IFN
 ✅  Branch to ELSE on positive values with IFP
 ✅  Handle nested branching with IFP...ELSE
 ✅  Handle nested branching with IFP
 ✅  Branch on positive values with IFP
 ✅  Branch on zero values with IFZ
 ✅  Branch to ELSE on non-zero values with IFZ
 ✅  Handle nested branching with IFZ
 ✅  Break from a LOOP construct
 ✅  Break from LOOP based on a counter
 ✅  Allow for nested LOOP constructs
 ✅  Calculate modulus between Integer literal
 ✅  Multiply several Integer literals
 ✅  Handle precedence with parentheses
 ✅  Handle precedence of mathematical operators
 ✅  Calculate all the primes up to 23
 ✅  Print an integer literal
 ✅  Print multiple integer literals
 ✅  Subtract Integer literals
 ✅  Allow use of unassigned variable identifiers
```

Once built, the command line utility in `bin/` can also be pointed at any `.bitsy` file
or directory containing multiple `.bitsy` files. Each `.bitsy` file found is run.

```bash
bin/bitsyspec
usage: bitsyspec bitsy_path spec_path
      run spec(s) at spec_path using bitsy implementation at bitsy_path
```

If the file is prepended with a code comment
which defines the expected output,`bitsyspec` will run the spec and report
success or failure. The comment must be in the
[correct format](specs/fibonacci.bitsy#L1).

*Note: `bitsyspec` assumes your implementation takes a `.bitsy` file as
its only argument, which it can immediately run. Depending on the details of your
implementation you may have to wrap it in a shell script to achieve this. See
`bitsy-swift`'s
[runbitsy](https://github.com/apbendi/bitsy-swift/blob/master/runbitsy)
for an example.*

## Language Specification

This repo contains a collection of specs
in the `/specs` [directory](specs). The goal is to for the specs contained
there to fully define Bitsy, such that:

 * An implementation passing all specs is considered a valid Bitsy implementation
 * A change to the language would be expressed by a change to or addition of
   a spec

At the moment, the specs are woefully short of this goal. Where an undefined
behavior or ambiguity exists in the language, the behavior of the current
canonical implementation ([bitsy-swift](https://github.com/apbendi/bitsy-swift))
should be assumed. Please open an issue to report these!

Want to help us get closer to a fully defined and spec'd language? Consider...

## Contributing

Contributions are welcome, and there's lots to do! BitsySpec, both the utility
and the spec suite, are considered version `0.1.0` at this point. Your feedback
and help are needed.

Discussions about changing the language are welcomed, and will be considered
by their alignment with Bitsy's goal: to be a teaching and learning
tool for programmers interested in language implementation.

Probably the best thing you could do right now is attempt your own implementation
of Bitsy in your favorite language. Your experience in doing so will provide
invaluable feedback!

Please be kind and respectful of others when participating!

## Implementations

The first-and-canonical implementation of Bitsy is
[bitsy-swift](https://github.com/apbendi/bitsy-swift), a compiler written in
Swift.

Open a pull request to add your implementation to the list!
