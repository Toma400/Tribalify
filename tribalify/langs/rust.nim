#[ TRIBALIFY / LANGS / RUST ]#
#[
    This section is not meant to emulate all Rust features, especially given
    there are much better libraries to do this (for example 'results').
    Those should be first choices of whoever wants to bring Rust into Nim.
    Tribalify section is only meant to provide some useful utilities known
    from Rust into Nim environment, but limited to what Tribalify author
    found valuable to bring here.
]#

# Rust aliases for int/unsigned int/float types
type
  i8*  = int8
  i16* = int16
  i32* = int32
  i64* = int64
  u8*  = uint8
  u16* = uint16
  u32* = uint32
  u64* = uint64
  f32* = float32
  f64* = float64