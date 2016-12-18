(*
 * tui.mli
 * Copyright (C) 2016 yqiu <yqiu@f24-suntzu>
 *
 * Distributed under terms of the MIT license.
 *)
open Board

val init : unit -> unit

val display : Grid.t Monad.t -> unit

