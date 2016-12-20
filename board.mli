(*
 * board.ml
 * Copyright (C) 2016 yqiu <yqiu@f24-suntzu>
 *
 * Distributed under terms of the MIT license.
 *)

type turns = int
type score = int
type 'a t = 'a * turns * score

module type Rep = sig
  (* leaving for now for testing, will abstract out eventually *)
  type t
  val move_left : t -> t * turns * score
  val move_right : t -> t * turns * score
  val move_up : t -> t * turns * score
  val move_down : t -> t * turns * score
  val to_list : t -> int list list
  val init : int -> int -> t
end

module Grid : Rep

val init : int -> int -> Grid.t t

val move_left : Grid.t t -> Grid.t t

val move_right : Grid.t t -> Grid.t t

val move_up : Grid.t t -> Grid.t t

val move_down : Grid.t t -> Grid.t t

val spawn : Grid.t t  -> Grid.t t

val turns : Grid.t t -> int

val score : Grid.t t -> int

val moves_available : Grid.t t -> bool

val contains_win : Grid.t t -> bool


