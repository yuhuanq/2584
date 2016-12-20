#
# Makefile
# yqiu, 2016-12-17 21:16
#

all:
	# ocamlbuild fib.cma fib.cmxa
	# ocamlbuild board.cma board.cmxa
	# ocamlbuild logic.cma logic.cmxa
	# ocamlbuild input.cma input.cmxa
	# ocamlbuild tui.cma tui.cmxa
	ocamlbuild -use-ocamlfind -pkgs unix main.byte

test:
	ocamlbuild -pkgs oUnit test.byte && ./test.byte

clean:
	ocamlbuild -clean


# vim:ft=make
#
