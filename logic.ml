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
end

(* fun action : board -> board * status *)
(* fun board.move_left : board -> board *)
open Monad
let move t mv =
  match mv with
  | Left ->
    t >>= fun b ->
      return (Board.move_left b) >>= fun b ->
        return (Board.spawn b)
  | Right ->
      t >>= fun b ->
        return (Board.move_right b) >>= fun b ->
          return (Board.spawn b)
  | Up ->
      t >>= fun b ->
        return (Board.move_up b) >>= fun b ->
          return (Board.spawn b)
  | Down ->
      t >>= fun b ->
        return (Board.move_down b) >>= fun b ->
          return (Board.spawn b)

let init n =
  Random.self_init ();
  let board = Board.init n n in
  return board >>= fun b ->
    return (Board.spawn b) >>= fun b ->
      return (Board.spawn b)

