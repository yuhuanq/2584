#
# Makefile
# yqiu, 2016-12-17 21:16
#

all:
	ocamlbuild fib.byte

test:
	ocamlbuild -pkgs oUnit test.byte && ./test.byte

clean:
	ocamlbuild -clean


# vim:ft=make
#
