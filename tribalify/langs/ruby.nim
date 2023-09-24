#[ TRIBALIFY / LANGS / RUBY ]#
#[
    This section is not meant to emulate all Ruby features.
    Tribalify section is only meant to provide some useful utilities known
    from Ruby into Nim environment, but limited to what Tribalify author
    found valuable to bring here.
]#
from ../../tribalify import whisper, scribe

proc puts* (msg: varargs[typed, `$`])         = whisper(msg)
proc gets* (msg: varargs[typed, `$`]): string = scribe(msg)

#[--- END BLOCKS ------------------------------------------------------------------
Ruby-like end templates. Purely visual, so can be used optionally and Nim won't
care if you use wrong one! It is for helpful transition from Ruby/Pascal, or for
those who like design of end type.
-------------------------------------------------------------------------------]#
template endIf*    = discard     # for conditions
template endLoop*  = discard     # for loops
template endProc*  = discard     # for procs
template endBlock* = discard     # for block
template endTab*   = discard     # for Tribalify 'tab'
template endClass* = discard     # for Classes 'class'
template endMisc*  = discard     # for all other types