# Tribalify
**Tribalify** is syntax sugar library aimed on creating Nim interface for 
indev programming language called Tribal.  
Tribalify offers Tribal features by adding them onto Nim experience by use of macros,
templates and other procedures. They are all available under `tribalify` file.

### Contents
- [Why Tribalify](#why-tribalify)
- [Installation & usage](#installation--usage)
- Features
  - [New types](#new-types)
  - [Aliases](#aliases)
  - [Functionalities](#functionalities)
  - [Syntax sugar](#syntax-sugar)

### Why Tribalify?

### Installation & usage

### New types
- `pair(F, S)` - convenience type for double values:
  - initialise with `newPair()` proc
  - can be stringified (`$`) to get string repr
  - use `.first` and `.second` to get specific field
- `triad(F, S, T)` - convenience type for triple values:
  - initialise with `newTriad()` proc
  - can be stringified (`$`) to get string repr
  - use `.first`, `.second` and `.third` to get specific field

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
- `<!` and `!>` append elements to mutable collection-like types (equivalent of `.add`)