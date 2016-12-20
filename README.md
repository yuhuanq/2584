# 2584
A Fibonacci variant of the popular 2048 game.

Implemented monadically with Board and Logic both as monads. i.e. to chain move
operations

`t >>= lift Board.move_up >>= spawn >>= lift Board.movedown` where `t : Logic.t`

Text based interface only at the moment.

Tested and built with OCaml 4.03.

`make`

`./main.byte`

