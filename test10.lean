import Lean.Elab.Tactic.BVDecide
open scoped BitVec

example (x y : BitVec 64) : decide (((x - y) ||| (y - x)) = 0) = decide (x = y) := by
  bv_decide
