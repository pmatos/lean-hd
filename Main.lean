import LeanHd

open LeanHd
open scoped BitVec

private def pow2Int (n : Nat) : Int :=
  Int.ofNat (Nat.pow 2 n)

private def int64Min : Int :=
  - (pow2Int 63)

private def int64Max : Int :=
  pow2Int 63 - 1

def parseBitVec64 (s : String) : Except String (BitVec 64) := do
  let some i := s.toInt?
    | throw s!"{s} is not a valid integer literal"
  if int64Min ≤ i ∧ i ≤ int64Max then
    pure (BitVec.ofInt 64 i)
  else
    throw s!"{i} is outside the signed 64-bit range [{int64Min}, {int64Max}]"

def readArg (s : String) : IO (BitVec 64) :=
  match parseBitVec64 s with
  | .ok v => pure v
  | .error msg => throw <| IO.userError msg

def runComparison (a b : String) : IO Unit := do
  let x ← readArg a
  let y ← readArg b
  if diffDifferent x y then
    IO.println "Different!"
  else
    IO.println "Same!"

private def usage : String :=
  "Usage: lean-hd <x> <y>  -- compares two signed 64-bit integers"

def main (args : List String) : IO Unit :=
  try
    match args with
    | [a, b] => runComparison a b
    | _ => IO.eprintln usage
  catch e =>
    IO.eprintln e.toString
