## Bitsy

Bitsy is a programming language. The primary goal of Bitsy is to be easy to implement.
Specifically, Bitsy aims to be the best language to target when building your
first compiler or interpreter.

A secondary goal of Bitsy is to look vaguely familiar to most imperative
programmers. In contrast to other languages often used to teach language implementation,
such as [BF]() or [Lisp](), Bitsy is comparable at first glance to "typical" programming
languages.

A non-goal of Bitsy is to be useful in itself as a language. It is only just
possible to write borderline useful programs in Bitsy, such as calculating
factorials or prime numbers.  Bitsy qua Bitsy *might* be useful as teaching tool
if used as an early introduction to programming for new students, such as
those in elementary Math.

## BitsySpec

BitsySpec aims to codify the definition of Bitsy in a series of tests that can
be run against any Bitsy implementation. BitySpec consists of two parts:

 1. A command line utility for running test specifications against any
    implementation of Bitsy
 2. A series of "specs", Bitsy programs pair with their expected output, to test
    the correctness of a given Bitsy implementation

The command line utility that can be pointed at any `.bitsy` file
or a directory containing multiple `.bitsy` files. Each file is a program written
in the Bitsy language prepended with a code comment in a format which
defines the expected output. The BitsySpec command line utility
runs each program with the implementation of Bitsy provided and validates
the output produced matches that expected.

This repo also contains a collection of specs
in the `/specs` directory. The goal is to for the specs contained there to fully
define a "correct" implementation of Bitsy.

## Bitsy Language Definition

While the hope of this repo is to codify the definition of Bitsy in a series of
runnable tests, it is also useful to define the language informally using words.

### Program Definition

All Bitsy programs start with the `BEGIN` keyword and are terminated with the
`END` keyword. The smallest valid Bitsy program is:

```bitsy
BEGIN
END
```

A Bitsy program may have an arbitrary amount of whitespace or comments before
the `BEGIN` keyword or after the final `END`, but the executable body of the program
exists completely between these keywords.

### Data types

Bitsy has only one data type: signed integers. The range of
Bitsy's integer type is currently not defined. It is suggested to use the largest
signed range possible for the architecture your implementation targets.

### Arithmetic

Bitsy supports the `+`, `-`, `*`, `/`, and `%` infix operators for addition, subtraction,
multiplication, division (integer), and modulus. Standard precedence rules are used.
Expressions may also be prepended with `+` or `-` operator for expressing signed-ness.
Arithmetic operators may not be used in succession. For example, `2 - -2` is an
error; it does *not* evaluate to 4. Similarly, `2 * -2` is wrong. Parentheses can be
used to alter the order of operations as expected. Parentheses can be nested, but must
be balanced.

### Variables

Variables in Bitsy consist of letters and underscores. Variables are case sensitive.
There is no limit to the number of characters in a Bitsy variable, nor are there any
rules about how they are named.

No initialization or declaration of variables is required. If a variable is accessed
before first being assigned its value is `0`.

Variable assignment is performed using the `=` infix operator. The variable name
to the left of the operator is assigned to the evaluated expression on the right.
Variables may be assigned the values of other variables. Arithmetic expressions may
include variables as terms.

### I/O

Bitsy has two built in keywords for user input and output.

The `PRINT` keyword is used for output. It is followed by whitespace and any
valid expression and the result is output to stdout followed by a
single newline (`\n`).

THE `READ` keyword is used to take input from the user. It is followed by whitespace
and a variable name. When a Bitsy program evaluates a `READ` command, it pauses
to take input from the user and reads that input as an integer value. The value
received is loaded into the variable specified. Any value previously stored in
that variable is overwritten.

### Loops

Bitsy has only one loop construct: `LOOP`...`END`. Everything within a loop-end
block is repeated indefinitely. A loop is exited with the `BREAK` keyword.
When `BREAK` is evaluated, control moves from the break statement to the terminating
`END` keyword. `LOOP` blocks may be nested. A `BREAK` exits only the inner most loop.
The behavior of a `BREAK` keyword outside a loop block is currently undefined.

### Conditionals

Despite having no boolean data type, Bitsy has three conditional statements:
`IFP`, `IFZ`, and `IFN`. Each statement is followed by an expression, an
optional `ELSE`, and a closing `END`. The statement
proceeds based the evaluation of the expression provided after the first
component of the conditional.

An `IFP` statement evaluates the conditional block
if the expression evaluates to a positive value. An `IFZ` statement evaluates the
conditional block if the expression evaluates to exactly zero. An `IFN` statement
evaluates the conditional block if the expression evaluates to a negative value.

### Comments

Bitsy supports block style code comments. Comments begin with the `{` character
and end with `}`. Any combination of characters may be present between the brackets.
Comment blocks may span multiple lines. Comment blocks can *not* be nested.
Comments can appear before the `BEGIN` keyword or after the program terminating
`END` keyword.
