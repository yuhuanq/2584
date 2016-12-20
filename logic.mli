(*
 * logic.mli
 * Copyright (C) 2016 yqiu <yqiu@f24-suntzu>
 *
 * Distributed under terms of the MIT license.
 *)

type status = Playing | Win | Lose
type move = Up | Down | Left | Right
(* monad *)
type t = Board.Grid.t Board.t * status

val turns : t -> int
val score : t -> int

val move : t -> move -> t

val init : int -> t
