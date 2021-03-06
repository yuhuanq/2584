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

type continue = Yes | No

let rec yn_input () =
  match Input.get_char () with
  | 'y' -> Yes
  | 'n' -> No
  | _ -> yn_input ()

(* t : Logic.t *)
let rec loop t =
  Tui.render t;
  let mv = input () in
  let t' = Logic.move t mv in
  match snd t' with
  | Logic.Playing ->
      loop t'
  | Logic.Win ->
      Tui.win ();
      loop t'
  | Logic.Lose ->
      Tui.lose ();
      begin match yn_input () with
      | Yes ->
        main ()
      | No ->
        Tui.goodbye ();
        exit 0
      end

and main () =
  let newgame = Logic.init 4 in
  loop newgame

let () = main ()

