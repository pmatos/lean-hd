import Lean.Elab.Tactic.BVDecide

namespace LeanHd

open scoped BitVec

/-- The bit mask from Hacker's Delight: `(x - y) ||| (y - x)`. -/
def diffMask (x y : BitVec 64) : BitVec 64 :=
  (x - y) ||| (y - x)

/-- Returns `true` precisely when `x` and `y` are different, computed via the bit mask. -/
def diffDifferent (x y : BitVec 64) : Bool :=
  decide (diffMask x y ≠ 0)

theorem diffMask_eq_zero_decide (x y : BitVec 64) :
    decide (diffMask x y = 0) = decide (x = y) := by
  classical
  unfold diffMask
  bv_decide

theorem diffDifferent_spec (x y : BitVec 64) :
    diffDifferent x y = decide (x ≠ y) := by
  classical
  unfold diffDifferent diffMask
  bv_decide

theorem diffMask_ne_zero_iff (x y : BitVec 64) :
    diffMask x y ≠ 0 ↔ x ≠ y := by
  classical
  have hbool :
      decide (diffMask x y ≠ 0) = decide (x ≠ y) := by
    simpa [diffDifferent] using diffDifferent_spec x y
  constructor
  · intro h
    have hx : decide (diffMask x y ≠ 0) = true := decide_eq_true h
    have : decide (x ≠ y) = true := hbool ▸ hx
    exact of_decide_eq_true this
  · intro h
    have hx : decide (x ≠ y) = true := decide_eq_true h
    have : decide (diffMask x y ≠ 0) = true := hbool.symm ▸ hx
    exact of_decide_eq_true this

theorem diffMask_eq_zero_iff (x y : BitVec 64) :
    diffMask x y = 0 ↔ x = y := by
  classical
  constructor
  · intro h
    have hx : decide (diffMask x y = 0) = true := decide_eq_true h
    have : decide (x = y) = true := (diffMask_eq_zero_decide x y) ▸ hx
    exact of_decide_eq_true this
  · intro h
    have hx : decide (x = y) = true := decide_eq_true h
    have : decide (diffMask x y = 0) = true :=
      (diffMask_eq_zero_decide x y).symm ▸ hx
    exact of_decide_eq_true this

end LeanHd
