import Lean.Elab.Tactic.BVDecide
open scoped BitVec

example (x : BitVec 64) : (x - x) ||| (x - x) = (0 : BitVec 64) := by
  bv_decide
