# 2584
A Fibonacci variant of the popular 2048 game.

Implemented monadically with Board and Logic both as monads. i.e. to chain move
operations

`t >>= lift Board.move_up >>= spawn >>= lift Board.movedown` where `t : Logic.t`

Text based interface only at the moment.

## Compiling and running

Tested and built with OCaml 4.03. Support for Unix systems only.

`make`

`./main.byte`

`hjkl` to move left,down,up,right respectively

`r` to restart with a fresh board

