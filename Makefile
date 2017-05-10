ALL:
	bison -d analisador_sintatico.y
	flex analisador_lexico_pt2.l
	gcc analisador_sintatico.tab.c lex.yy.c -lfl