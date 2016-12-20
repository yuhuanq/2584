(*
 * main.ml
 * Copyright (C) 2016 yqiu <yqiu@f24-suntzu>
 *
 * Distributed under terms of the MIT license.
 *)

let rec input () =
  match Input.get_char () with
  | 'h' -> Logic.Left
  | 'j' -> Logic.Down
  | 'k' -> Logic.Up
  | 'l' -> Logic.Right
  | _ -> input ()

(* t : Logic.t *)
let rec loop t =
  Tui.render t;
  let mv = input () in
  let t' = Logic.move t mv in
  loop t'

let main () =
  let newgame = Logic.init 4 in
  loop newgame

let () = main ()

