all: task1 task2

task2: task2.l task2.y
	bison -d task2.y
	flex task2.l
	gcc -Wall lex.yy.c task2.tab.c -o task2 -lm

task1: infix.l infix.y
	bison -d infix.y
	flex infix.l
	gcc lex.yy.c infix.tab.c -o infix -lm

clean:
	rm -f p2 cal.output *.o cal.tab.c lex.yy.c *.tab.* *.yy.*
