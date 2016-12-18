(*
 * test.ml
 * Copyright (C) 2016 yqiu <yqiu@f24-suntzu>
 *
 * Distributed under terms of the MIT license.
 *)

open OUnit
open Board

let r1 = [|2;0;0;0|]
let r2 = [|0;13;21;0|]
let r3 = [|1;1;0;0|]
let r4 = [|0;0;0;0|]
let g = [|
  r1;r2;r3;r4
|]

let r1' = r1 |> Array.to_list |> List.rev |> Array.of_list
let r2' = [|0;0;0;34|]
let r3' = [|0;0;0;2|]
let r4' = r4
let g_right = [|
  r1';r2';r3';r4'
|]

let r1'' = [|3;13;21;0|]
let r2'' = [|0;1;0;0|]
let r3'' = [|0;0;0;0|]
let r4'' = r3''
let g_up =[|
  r1'';r2'';r3'';r4''
|]

let r1_d = r3''
let r2_d = r1_d
let r3_d = [|0;13;0;0|]
let r4_d = [|3;1;21;0|]
let g_down = [|
  r1_d;r2_d;r3_d;r4_d
|]

let fst' (a,b,c) = a

let tests = "test suite" >::: [
  "move_right" >:: (fun _ -> assert_equal g_right (fst' (Grid.move_right g)));
  "move_up" >:: (fun _ -> assert_equal g_up (fst' (Board.Grid.move_up g)));
  "move_down" >:: (fun _ -> assert_equal g_down (fst' (Grid.move_down g)));
]

let _ = OUnit.run_test_tt_main tests




