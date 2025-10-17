import Lake
open Lake DSL

package "lean-hd" where
  version := v!"0.1.0"

lean_lib «LeanHd» where
  -- add library configuration options here

@[default_target]
lean_exe "lean-hd" where
  root := `Main
