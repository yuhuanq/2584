(*
 * board.ml
 * Copyright (C) 2016 yqiu <yqiu@f24-suntzu>
 *
 * Distributed under terms of the MIT license.
 *)
type turns = int
type score = int

module type G = sig
  type t
  val to_list : t -> int list list
end

(* namespace for grid related methods *)
module Grid = struct
  type t = int array array

  (* empty cells = 0 *)
  let empty = 0

  (* [init x y] initializes a new game grid of dim x y *)
  let init x y : t =
    Array.make_matrix x y 0

  let set g x y nw : t =
    g.(x).(y) <- nw; g

  let get g x y : int =
    g.(x).(y)

  (* to 2d list *)
  let to_list g =
    g |> Array.map Array.to_list |> Array.to_list

  let rec format_grid (grid : int list list) : unit =
    match grid with
    | [] -> ()
    | []::tl -> format_grid tl
    | [h]::tl -> Printf.printf "| %d |\n" h; format_grid tl
    | (h::t)::tl -> Printf.printf "| %d |" h; format_grid (t::tl)

  (* use format_grid to print a value to the console *)
  let print_grid g = g |> to_list |> format_grid

  let contains_win g =
    g |> to_list |> List.flatten |> List.mem 2584

  let empty_cells g : (int * int) list option =
    let dimx,dimy = Array.length g.(0), Array.length g in
    let acc = ref [] in
    for x = 0 to dimx-1 do
      for y=0 to dimy-1 do
        if g.(x).(y) = 0 then
          begin acc := (x,y)::!acc end
      done;
    done;
    if List.length !acc > 0 then Some !acc
    else None

  let transpose mx =
    let sizex,sizey = Array.length mx, Array.length mx.(0) in
    let b = Array.make_matrix sizey sizex 0 in
    for x = 0 to sizex-1 do
      for y = 0 to sizey-1 do
        b.(y).(x) <- mx.(x).(y)
      done;
    done;
    b

  let merge lst =
    let rec loop acc removed lst =
      match lst with
    | [] -> List.rev acc, removed
    | h::h2::t ->
        begin
          if (Fib.is_adj h h2) then
            (* add padding *)
            loop (h+h2::acc) (h::h2::removed) t
          else
            loop (h::acc) removed (h2::t)
        end
    | [h] -> List.rev (h::acc), removed in
    let interm = loop [] [] lst in
    let rec add_padding lst n =
      if n=0 || n<0 then lst
      else add_padding (lst @ [empty]) (n-1) in
    let orig_len = List.length lst in
    if orig_len > (List.length (fst interm)) then
      add_padding (fst interm) (orig_len - (List.length (fst interm))), snd interm
    else
      interm

  let merge_left arr =
    let len = Array.length arr in
    let buf = Array.make len 0 in
    let k = ref 0 in
    for i=0 to len-1 do
      if arr.(i) <> empty then
        begin
          buf.(!k) <- arr.(i);
          k:= !k + 1
        end
    done;
    let arr',rmd = merge (Array.to_list buf) in
    Array.of_list arr',rmd

  (* [merge_right arr] shifts elts in arr rightwards and merges*)
  let merge_right arr =
    let len = Array.length arr in
    let buf = Array.make len 0 in
    let k = ref (len-1) in
    for i=len-1 downto 0 do
      if arr.(i) <> empty then
        begin
          buf.(!k) <- arr.(i);
          k:= !k - 1
        end
    done;
    let buf' = List.rev (Array.to_list buf) in
    let arr',rmd = merge buf' in
    Array.of_list (List.rev arr'),rmd

  let move fmerge g =
    let g',rmd = Array.map fmerge g |> Array.to_list |> List.split in
    let score = rmd |> List.flatten |> List.fold_left (+) 0 in
    Array.of_list g',0,score

  let move_right g =
    move merge_right g

  let move_left g =
    move merge_left g

  let move_up g =
    let g' = transpose g in
    let g'',t,score = move merge_left g' in
    transpose g'',t,score

  let move_down g =
    let g' = transpose g in
    let g'',t,score = move merge_right g' in
    transpose g'',t,score
end

type 'a t = 'a * turns * score

module Monad = struct
  type 'a t = 'a * turns * score
  let return g = g,0,0
  let bind (grid,turns,score) f =
    let grid',_,gains = f grid in
    if grid <> grid' then
      (grid',turns+1,score+gains)
    else
      (grid',turns,score)
end

open Monad
let (>>=) = bind

let init x y = return (Grid.init x y)
let move_left board = board >>= Grid.move_left
let move_right board = board >>= Grid.move_right
let move_up board = board >>= Grid.move_up
let move_down board = board >>= Grid.move_down

let spawn (grid,turns,score) =
  match Grid.empty_cells grid with
  | None -> grid,turns,score
  | Some lst ->
      let n = List.length lst in
      let (x,y) = List.nth lst (Random.int n) in
      let grid' = Grid.set grid x y 1 in
      grid',turns,score

let turns ((_,ts,_):Grid.t t) = ts
let score ((_,_,sc):Grid.t t) = sc

let fst' (a,_,_) = a
let moves_available t =
  let has_empty_cells =
    match Grid.empty_cells (fst' t) with
    | Some _ -> true
    | None -> false in
  has_empty_cells ||
  fst' (move_left t) <> fst' t ||
  fst' (move_right t) <> fst' t ||
  fst' (move_down t) <> fst' t ||
  fst' (move_up t) <> fst' t

let contains_win t =
  Grid.contains_win (fst' t)

