(*
 * Fibonacci.ml
 * Copyright (C) 2016 yqiu <yqiu@f24-suntzu>
 *
 * Distributed under terms of the MIT license.
 *)

let is_adj a b =
  if a <> 1 && a = b then false
  else
    let smaller = min a b in
    let d = abs (a - b) in
    if d > smaller then false
    else true

