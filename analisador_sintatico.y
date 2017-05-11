%{
#include <stdio.h>
%}

// Symbols.
%define parse.error verbose
%define parse.lac full

%union
{
  char *sval;  
  float fval;
  int	ival;
	
};

%token ABRE_P
%token COMECO
%token CONST
%token DP
%token END
%token FECHA_P
%token ID
%token IGUAL
%token INTEIRO
%token OP_AD
%token OP_MUL
%token OP_RELACIONAL
%token PF
%token PROCEDURE
%token PROGRAMA_ID
%token PV
%token REAL
%token TIPO_VAR
%token VAR
%token VIRGULA
%token RW
%token RECEBE
%token IF
%token THEN
%token ELSE

%start Programa

%%
Programa:
	PROGRAMA_ID ID PV Corpo PF
	;

Corpo:
  Dc COMECO Comandos END
  ;
  
Dc:
  Dc_c Dc_v Dc_p
  ;
  
Dc_c:
  /* lambda */
  | CONST ID IGUAL Numero PV Dc_c
  ;

Dc_v:
  /* lambda */
  | VAR Variaveis DP Tipo_var PV Dc_v
  ;

Tipo_var:
  TIPO_VAR
  ;

Variaveis:
  ID Mais_var
  ;
  
Mais_var:
  /* lambda */
  | VIRGULA Variaveis
  ;
  
Dc_p:
  /* lambda */
  | PROCEDURE ID Parametros PV Corpo_p Dc_p
  ;
  
Parametros:
   /* lambda */
  | ABRE_P Lista_par FECHA_P
  ;
  
Lista_par:
  Variaveis DP Tipo_var Mais_par
  ;
  
Mais_par:
  /* lambda */
  | PV Lista_par
  ;
  
Corpo_p:
  Dc_loc COMECO Comandos END PV
  ;
  
Dc_loc:
  Dc_v
  ;
  
Lista_arg:
   /* lambda */
  | ABRE_P Argumentos FECHA_P
  ;
  
Argumentos:
  ID Mais_ident
  ;

Mais_ident:
   /* lambda */
   | PV Argumentos
   ;
   
Else:
  /* lambda */
  | ELSE Cmd
  ;
  
Comandos:
  /* lambda */
  | Cmd PV Comandos
  ;
  
Cmd:
  RW ABRE_P Variaveis FECHA_P   
  |IF Condicao THEN Cmd Else
  |ID RECEBE Expressao
  |ID Lista_arg
  |COMECO Comandos END
  ;

Condicao:
  Expressao Relacao Expressao
  ;

Expressao:
  Termo Outros_termos
  ;
  
Relacao:
  OP_RELACIONAL
  ;

Op_un:
  /* lambda */
  | OP_AD
  ;

Outros_termos:
  /* lambda */
  | Op_ad Termo Outros_termos
  ;
  
Op_ad:
  OP_AD
  ;
  
Termo:
  Op_un Fator Mais_fatores
  ;

Mais_fatores:
  /* lambda */
  | Op_mul Fator Mais_fatores
  ;

Op_mul:
  OP_MUL
  ;
  
Fator:
  ID
  | Numero
  | ABRE_P Expressao FECHA_P
  ;
  
Numero:
  INTEIRO
  | REAL
  ;
%%
  
int yyerror(char *s) {
  printf("yyerror : %s\n",s);
  return 0;
}

int main(void) {
  yyparse();
}