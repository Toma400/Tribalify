#[ TRIBALIFY / EXPERIMENTAL ]#
#[
    Used to experiment with new features, as well as adding the ones
    I see as too radical for normal Tribalify use
]#

import std/typetraits

proc anyIt [T](comp: T, vars: tuple): bool =
    for v in vars.fields:
      if comp == v: return true
    return false
proc anyIt [T, I](comp: T, vars: array[I, T]): bool =
    for v in vars:
      if comp == v: return true
    return false
proc allIt [T](comp: T, vars: tuple): bool =
    for v in vars.fields:
      if comp != v: return false
    return vars.tupleLen > 0
proc allIt [T, I](comp: T, vars: array[I, T]): bool =
    for v in vars:
      if comp != v: return false
    return vars.len > 0

#[ Alias for [if x == "a" or "b" or "c"] ]#
template `=?=`* (a: untyped, b: (untyped)): untyped =
    anyIt(a, b) # tuple (type agnostic)

template `=?=`* [I](a: untyped, b: array[I, untyped]): untyped =
    anyIt(a, b) # array (type precise)

#[ Alias for [if x == "a" and "b" and "c"] ]#
template `=:=`* (a: untyped, b: (untyped)): untyped =
    allIt(a, b) # tuple (type agnostic)

template `=:=`* [I](a: untyped, b: array[I, untyped]): untyped =
    allIt(a, b) # array (type precise)