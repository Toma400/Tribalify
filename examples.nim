import tribalify

tab:     # 'tab' sets visual identation section
  var town1: str = "Athens"   # 'str' is alias for 'string' type and can be used interchargeably
  var town2: str = "Paris"

  var list_of_towns = @[town1, town2]

# since 'tab' does not create new scope, we can use variables declared above here
let town1_king = newPair(town1, "Alexander the Great") # pair (two values)
let town2_king = newPair(town2, "Louis XIV")

let town1_info = newTriad(town1, "Greece", 643_452) # triad (three values)
let town2_info = newTriad(town2, "France", 2_102_650)

# you can also convert tuples into pairs/triads if length of tuple matches
echo (10, 15).toPair
echo (10, 15, 20).toTriad
echo (10, 15, 20, 50).toTriad # this should result in exception error

# operator '&&' is alias for 'and'
assert true && true == true
assert true && false == false
assert false && false == false
# operator '||' is alias for 'or'
assert true || true == true
assert true || false == true
assert false || false == false
# operator '<>' is alias for 'xor'
assert true <> true == false
assert true <> false == true
assert false <> false == false

# proc aliases
whisper "This works just like echo"
var town3 = scribe "And here you can readLine from stdin, as well as echo the message beforehand"

# isAny let you check multiple values without doing tedious 'town3 == X or town3 == Y or town3 == Z'
if not town3.isAny(town1, town2):
    # <! adds element from '!' side into list on the left. !> works in reversed way
    list_of_towns <! town3