#[=== TRIBAL LIB ================================================================
  Small library file that introduces procedures, syntax and data types derived
  from my own indev programming language, Tribal. It is kinda bundle of other
  language features and some new ones made exclusively for Tribal.

  Libs that go well alongside:
    - classes      - introducing Python-like OOP with class type
    - questionable - introducing Kotlin-like syntax sugar for Option
    - results      - for Rust-like Result type
    - with         - for JS-like deprecated 'with' feature (kinda disruptive)
=============================================================================]##[
  Types:
    - pair(F,S)    - type that contains two values. Initialised with newPair()
    - triad(F,S,T) - type that contains three values. Initialised with newTriad()
  Aliases:
    - str                           - alias for string type
    - puts(MessageTypes)            - alias for echo, but can take various types
                                      without stringifying
    - gets(?MessageTypes) >> string - alias for readLine(stdin), but can also
                                      print out message before getting input
    Aliases in pure Tribal:
      - whisper(MessageTypes)            - for puts()
      - scribe(?MessageTypes) >> string  - for gets()
  Operators:
    - && - logical AND
    - || - logical inclusive OR (A, B or both)
    - <> - logical exclusive OR (either A or either B)
  Collections:
    - <! - add to the appendable list
    - !> - add to the appendable list (reversed direction)
  Elegant code:
    - tab - identator which does not start new scope, but is only aesthetical
            (operates the same way Tribal uses 'block' as opposed to its 'scope')
===============================================================================]#
import std/tables
import std/macros
import std/json

type
  MessageTypes[T, I: int] =
    int | string | float | bool | seq[T] | array[I, T]
  str* = string # alias for string

#[--- PAIRS & TRIADS ------------------------------------------------------------
Introduces Pair and Triad, data structures from Kotlin that let you work on
objects with two or three values.
-------------------------------------------------------------------------------]#
type
  pair*[F,S] = object
    first:  F
    second: S
  triad*[F,S,T] = object
    first:  F
    second: S
    third:  T
proc newPair* [F,S](f: F, s: S): pair[F,S] =
  return pair[F,S](first: f, second: s)
proc newTriad* [F,S,T](f: F, s: S, t: T): triad[F,S,T] =
  return triad[F,S,T](first: f, second: s, third: t)
#[ Stringifying procedures for Pair and Triad type.
   For it to work, values need to be stringifyable. ]#
proc `$`* (p: pair): string =
  return "pair(" & $p.first & ", " & $p.second & ")"
proc `$`* (t: triad): string =
  return "triad(" & $t.first & ", " & $t.second & ", " & $t.third & ")"

#[--- QOL I/O -------------------------------------------------------------------
Procedures that bring some friendly aliases from other languages, such as Ruby
and Python. Allow for less cautious writing of standard I/O procedures.
-------------------------------------------------------------------------------]#
#[ Alias for 'echo', but you don't need to stringify primitive types ]#
proc puts* (msg: MessageTypes) =
    case $typeof(msg):
      of "string": echo msg
      else:        echo $msg

#[ Alias for readLine which mimicks Python's possibility to write before getting input ]#
proc gets* (msg: MessageTypes = ""): string =
    if msg != "": puts(msg)
    return readLine(stdin)

#[ Tribal aliases ]#
proc whisper* (msg: MessageTypes) =
    puts(msg)
proc scribe* (msg: MessageTypes = ""): string =
    return gets(msg)

#[--- QOL OPERATORS -------------------------------------------------------------
Brings alternative for OR and AND operators, with Tribal stylised manner. Thanks
to this, operator '<>' is also brought.
-------------------------------------------------------------------------------]#
#[ Alias for logical AND ]#
template `&&`* (a, b: untyped): untyped =
    (a and b)

#[ Alias for logical OR ]#
template `||`* (a, b: untyped): untyped =
    (a or b)

#[ Alias for logical excluding OR/XOR (only A or only B) ]#
template `<>`* (a, b: untyped): untyped =
    ((a or b) and not(a and b))

#[--- QOL LIST MANAGERS ---------------------------------------------------------
Tribal-based symbols of adding to iterable open types of data (sequences). Pushes
value from ! symbol to the list located at the arrow tip.

Works on every element that implements 'add(iterator, T)' function.
-------------------------------------------------------------------------------]#
template `<!`* (a, b: untyped): untyped =
    a.add(b)

template `!>`* (a, b: untyped): untyped =
    b.add(a)

#[--- CONTROL FLOW --------------------------------------------------------------
Useful tools from Tribal that let you control your code and its appearance.
-------------------------------------------------------------------------------]#
#[ Equivalent of Tribal's "block". Makes non-scoped (aesthetical) identator ]#
macro `tab`* (cont_given: untyped): untyped =
    var contents = newSeq[NimNode]() # tab's contents
    for c in cont_given:             # adds everything identated within tab
        contents <! c
    # list of tasks v___________v & adds block v______________________v & its body v____________v
    newStmtList(newSeq[NimNode]()) <! newBlockStmt(newNimNode(nnkEmpty)) <! newStmtList(contents)

#[--- COLLECTIONS --------------------------------------------------------------
Adds collection types that are missing from Tribal.
-------------------------------------------------------------------------------]#
#[ Dictionary, so mutable tuple/varied-typed table ]#
macro `@()`* (cont_given: untyped): untyped =
  discard

##### DICT
#[ dict jako tuples that will be copied + appended into to solve non-mutability:
     TUPLE1.add(X):
       (TUPLE1, X) ]#