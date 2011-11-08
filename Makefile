default:
	@echo "---------------"
	@echo "HLEX Makefile"
	@echo "---------------"
	@echo "  To compile hlex; use target 'hlex'"
	@echo "  To clean; use target 'clean'"
	@echo "  To bootstrap hlex (compile hlex lexer from hlex and hllr) use target 'bootstrap'"
	@echo "  To tar hlex, use option 'tar'"
	@echo ""


hlex: pre_process
	@echo "---------------"
	@echo "Compiling hlex!"
	@echo "---------------"
	mkdir -p bin
	haxe -cp src -neko bin/hlex.n -main Main
	nekotools boot bin/hlex.n
	
pre_process:
	@echo "---------------"
	@echo "Preprocessing hlex source"
	@echo "---------------"
	rm -rvf src
	mkdir src
	caxe cx-src $(SCX) -o src -tc 1 --times

clean:
	@echo "---------------"
	@echo "Cleaning hlex build"
	@echo "---------------"
	rm -f bin/hlex.n bin/hlex
	
bootstrap:
	@echo "---------------"
	@echo "Bootstrapping hlex!"
	@echo "---------------"
	hlex scripts/hlex.hlx -haxe cx-src/HLex.cx
	hllr scripts/hlex.hlr cx-src/HLlr.cx -haxe-gen -token Token -index TokenUtils.index -lalr1

tar:
	@echo "---------------"
	@echo "Tarring hlex"
	@echo "---------------"
	tar cvfz hlex.tar.gz cx-src scripts Makefile
