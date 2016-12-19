(*
 * logic.mli
 * Copyright (C) 2016 yqiu <yqiu@f24-suntzu>
 *
 * Distributed under terms of the MIT license.
 *)

type status = Playing | Over
type move = Up | Down | Left | Right
(* monad *)
type t = Board.Grid.t Board.t * status

val is_over : Board.Grid.t Board.t -> bool


val move : t -> move -> t

(* helpers for [move] : TODO: remove later *)
val move_left : Board.Grid.t Board.t -> t
val move_right : Board.Grid.t Board.t -> t
val move_up : Board.Grid.t Board.t -> t
val move_down : Board.Grid.t Board.t -> t

val turns : t -> int
val score : t -> int

