(*
 * logic.ml
 * Copyright (C) 2016 yqiu <yqiu@f24-suntzu>
 *
 * Distributed under terms of the MIT license.
 *)


type status = Playing | Win | Lose

type move = Up | Down | Left | Right

(* monad *)
type t = Board.Grid.t Board.t * status

let turns (b,_) = Board.turns b

let score (b,_) = Board.score b


let get_status t =
  if Board.contains_win (fst t) then Win
  else
    begin
    if Board.moves_available (fst t) then Playing else Lose
    end

module Monad = struct
  let return b = (b,Playing)
  let bind t f =
    let b = fst t in
    let res = f b in
    let status = get_status res in
    fst res, status
  let (>>=) = bind
  let lift f = fun b -> return (f b)
end

(* fun action : board -> board * status *)
(* fun board.move_left : board -> board *)
open Monad

let spawn b = return (Board.spawn b)

let move t mv =
  match mv with
  | Left ->
    t >>= lift Board.move_left >>= spawn
  | Right ->
      t >>= lift Board.move_right >>= spawn
  | Up ->
      t >>= lift Board.move_up >>= spawn
  | Down ->
      t >>= lift Board.move_down >>= spawn

let init n =
  Random.self_init ();
  let board = Board.init n n in
  return board >>= spawn >>= spawn

