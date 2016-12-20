(*
 * tui.ml
 * Copyright (C) 2016 yqiu <yqiu@f24-suntzu>
 *
 * Distributed under terms of the MIT license.
 *)

let hello () =
  print_endline "2584, a Fibonacci variant of the popular game 2048.";
  print_endline "Copyright (c) 2016, Yuhuan Qiu <yq56@cornell.edu>";
  print_endline "All rights reserved."


(*
 * print_endline "+----+----+----+----+";
 * print_endline "|   6|   8|   9|  10|"; * print_endline "+----+----+----+----+";
 * print_endline "|   6|   8|   9|  10|";
 * print_endline "+----+----+----+----+";
 * print_endline "|   6|   8|   9|  10|";
 * print_endline "+----+----+----+----+";
 * print_endline "|   6|   8|   9|  10|";
 * print_endline "+----+----+----+----+";
 *)

let display_border len =
  (* len = # cells  *)
  let rec make n acc =
    if n = 0 || n < 0 then acc
    else if n = 1 then make (n-1) (acc ^ "+----+")
    else if n = len then make (n-1) (acc ^ "+----")
    else make (n-1) (acc ^ "+----") in
  print_endline (make len "")

let display_row lst =
  display_border (List.length lst);
  let display_cell x =
    if x=0 then
      print_string "|    "
    else
      Printf.printf "|%4d" x in
  List.iter display_cell lst;
  print_string "|\n"

let display_board (b : Board.Grid.t Board.t) =
  let fst' (a,b,c) = a in
  let grid = fst' b in
  let lst = Board.Grid.to_list grid in
  List.iter display_row lst;
  display_border (List.length lst)

(* st : Logic.t *)
let render st =
  (* let status = snd st in *)
  let score = Logic.score st in
  let turns = Logic.turns st in
  Printf.printf "Score: %d\n" score;
  Printf.printf "Turn: %d\n" turns;
  display_board (fst st)

let goodbye () =
  print_endline "Thank you for playing.";
  print_endline "Goodbye.";

