import Init.Data.BitVec.Basic
open scoped BitVec

example (x : BitVec 64) : (x - x) = 0 := by
  simp
