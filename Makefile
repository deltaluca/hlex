all: pre_process
	haxe -cp src -neko bin/hlex.n -main Main
	nekotools boot bin/hlex.n

pre_process:
	rm -rvf src
	mkdir src
	caxe cx-src $(SCX) -o src -tc 2 --times

clean:
	rm -f bin/hlex.n bin/hlex
