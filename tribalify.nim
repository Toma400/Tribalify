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
import std/typetraits
import std/strformat
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
    first*:  F
    second*: S
  triad*[F,S,T] = object
    first*:  F
    second*: S
    third*:  T
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
#[--- Conversions for pair/triad ----------------------------------------------]#
#[ Tuple -> Pair. Requires two values in tuple ]#
proc toPair* [T, Y](tup: (T, Y)): pair[T, Y] =
  if tup.tupleLen == 2: return newPair(tup[0], tup[1])
  else:                 raise newException(Exception, fmt"Tried to convert tuple to pair, but used tuple of {tup.tupleLen} length instead of required 2.")
#[ Tuple -> Triad. Requires three values in tuple ]#
proc toTriad* [T, Y, X](tup: (T, Y, X)): triad[T, Y, X] =
  if tup.tupleLen == 3: return newTriad(tup[0], tup[1], tup[2])
  else:                 raise newException(Exception, fmt"Tried to convert tuple to triad, but used tuple of {tup.tupleLen} length instead of required 3.")

#[--- QOL I/O -------------------------------------------------------------------
Procedures that bring some friendly aliases from other languages, such as Ruby
and Python. Allow for less cautious writing of standard I/O procedures.
-------------------------------------------------------------------------------]#
#[ Alias for 'echo', but you don't need to stringify primitive types ]#
proc whisper* (msg: MessageTypes) =
    echo(msg)
#[ Alias for readLine which mimicks Python's possibility to write before getting input ]#
proc scribe* (msg: MessageTypes = ""): string =
    if msg != "": whisper(msg)
    return readLine(stdin)
#[ More common (Ruby-like) aliases ]#
proc puts* (msg: MessageTypes)         = whisper(msg)
proc gets* (msg: MessageTypes): string = scribe(msg)

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

#[ Alias for [if x == "a" or "b" or "c"] ]#
proc isAny* [T](v: T, args: varargs[T]): bool {.deprecated: "Use <T =?= (varargs)> instead".} =
    for arg in args:
      if v == arg: return true
    return false

#[ Alias for [if x == "a" and "b" and "c"] ]#
proc isAll* [T](v: T, args: varargs[T]): bool {.deprecated: "Use <T =:= (varargs)> instead".} =
    for arg in args:
      if v != arg: return false
    return args.len > 0

#[--- QOL LIST MANAGERS ---------------------------------------------------------
Tribal-based symbols of adding to iterable open types of data (sequences). Pushes
value from ! symbol to the list located at the arrow tip.

Works on every element that implements 'add(iterator, T)' function.
-------------------------------------------------------------------------------]#
template `<!`* (a, b: untyped): untyped =
    a.add(b)

# template `<!`* (a: untyped, b: varargs[untyped]): untyped =
#     a.add(b)

template `!>`* (a, b: untyped): untyped =
    b.add(a)

# template `!>`* (a: varargs[untyped], b: untyped): untyped =
#     b.add(a)

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
    # newBlockStmt(newNimNode(nnkEmpty)) <! newStmtList(contents)
    # newBlockStmt(newStmtList(contents))

# 0.2.0:
  # - tab Named:
  # - isAny albo 'x == a or b or c'

#echo (1, 5).toPair

# dumpTree:
#   tab:
#     discard
#
#   tab Test:
#     discard
#
#   block:
#     discard
#
#   block Named:
#     discard
#
#   if x == "a" or x == "b" or x == "c":
#     discard