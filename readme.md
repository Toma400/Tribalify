![](tribalify.png)

**Tribalify** is syntax sugar library aimed on creating Nim interface for 
indev programming language called Tribal.  
Tribalify offers Tribal features by adding them onto Nim experience by use of macros,
templates and other procedures. They are all available under `tribalify` file.

Take in mind that Tribalify's syntax may differ from pure Tribal. This is because
the library tries to incorporate itself into current Nim language.

### Contents
- [Why Tribalify](#why-tribalify)
- [Installation & usage](#installation--usage)
- Features
  - [New types](#new-types)
  - [Aliases](#aliases)
  - [Functionalities](#functionalities)
  - [Syntax sugar](#syntax-sugar)
- [Experimental features](#experimental)

### Why Tribalify?
Just because I love Nim, but there are some things from Tribal language ideas that
I wanted to see there as well. Tribalify is actually heavily inspired by other few
libraries that bring my beloved languages into Nim:
  - classes      - introducing Python-like OOP with class type
  - questionable - introducing Kotlin-like syntax sugar for Option
  - results      - introducing Rust-like Result type
  - with         - introducing JS-like deprecated 'with' feature

So, with such legacy, Tribalify was made as final step. It will try to be as small
as possible, yet trying to add as many Tribal-like features as it can.

### Installation & usage
Write following command in your terminal to install Tribalify using Nimble:
```commandline
nimble install https://github.com/Toma400/Tribalify
```
Once it is done, you can use Tribalify features simply after importing:
```nim
import tribalify

var i = newPair("Tom", "Parker")
whisper("Name of your son is: " & i.first)
```
Nimble by default installs latest release of Tribalify, so you may not be able to
use currently indev features (marked with ⚙️ emoji).  
If you want to play with new features before library updates, you can also use
this command in terminal instead:
```
nimble install https://github.com/Toma400/Tribalify@#HEAD
```

### New types
- `pair(F, S)` - convenience type for double values:
  - initialise with `newPair()` proc
  - can be stringified (`$`) to get string repr
  - use `.first` and `.second` to get specific field
  - use `.toPair` to convert tuple of 2 values to pair ⚙️
- `triad(F, S, T)` - convenience type for triple values:
  - initialise with `newTriad()` proc
  - can be stringified (`$`) to get string repr
  - use `.first`, `.second` and `.third` to get specific field
  - use `.toTriad` to convert tuple of 3 values to triad ⚙️

### Aliases
- Types:
  - `str` - alias for `string` type
- Operators:
  - `&&` - alias for `and`
  - `||` - alias for `or`
  - `<>` - alias for `xor` (exclusive OR)
- Procs:
  - `whisper(str)` - proc imitating `echo`. Also aliased as `puts(str)`
  - `scribe(str)` - proc imitating `readLine(stdin)` but with additional string evoking
  echo. Also aliased as `gets(str)`

### Functionalities
- `tab` - key used to separate sections of code aesthetically. Similar to Nim's `block`,
but does not create new scope. Example code:
```nim
block:
  var i = 5
echo i # will result in error, 'i' declared in different scope

tab:
  var y = 5
echo y # will work nicely, 'y' is in the same scope
```

### Syntax sugar
- `<!` and `!>`
  - append elements to mutable collection-like types. Works on every type that
  implements `.add` function, as it basically uses it in template
- `isAny(T, varargs[T])` ⚙️
  - let you check if first argument is any of next args. Equivalent of
  `if T == A or T == B or T == C ... `.
- `isAll(T, varargs[T])` ⚙️
  - let you check if first argument is all of next args. Equivalent of
  `if T == A and T == B and T == C ... `.

---
If you don't know how any of those concepts should be written, look at `examples.nim`
file to see code references.

---
### Experimental
You can use `import tribalify/experimental` to import features that are experimental
and not ready to use yet. Check `experimental.nim` file for further details.

<!-- CHANGELOG:
- 0.1.0:
  - Added pair/triad types
  - Added several aliases (str, or/and/xor operators, echo/readLine)
  - Added `tab` key
  - Added `<!` and `!>` sugar
- 0.2.0:
  - Added `isAny` and `isAll` functions
  - Added tuple conversions to pair/triad
  - Fixed:
    - [NOT YET] Not accessible pair/triad fields
-->