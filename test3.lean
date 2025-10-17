import Lean.Elab.Tactic.BVDecide
open scoped BitVec

lemma diffMask_ne_zero_of_ne (x y : BitVec 64) : x ≠ y → (x - y) ||| (y - x) ≠ 0 := by
  bv_decide
