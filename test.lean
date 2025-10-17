import Lean.Elab.Tactic.BVDecide
open scoped BitVec

def diffMask (x y : BitVec 64) : BitVec 64 :=
  (x - y) ||| (y - x)

def diffDifferent (x y : BitVec 64) : Bool :=
  decide (diffMask x y ≠ 0)
