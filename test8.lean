import Init.Data.Nat.Basic

variable (p : Prop) [Decidable p]

example (h : decide p = true) : decide (!p) = true := by
  have : decide (!p) = true := by
    simpa using h
  exact this
