import Lean.Elab.Tactic.BVDecide
open scoped BitVec

namespace Foo

lemma diffMask_zero_imp (x y : BitVec 64) : (x - y) ||| (y - x) = 0 → x = y := by
  bv_decide

end Foo
