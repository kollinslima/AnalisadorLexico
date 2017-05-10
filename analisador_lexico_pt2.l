/*
Afonso Henrique da Silva - 8910347
Kollins Gabriel Lima - 9012931
Lais Paiva - 7960939
*/
%{
    #include "analisador_sintatico.tab.h"
%}

letra           [a-z]|[A-Z]
digito          [0-9]
ident		    {letra}({letra}|{digito})*|_({letra}|{digito})*
tipo_var	    real|integer
comandos_rw     read|write
relacao         =|<>|>=|>|<
op_ad           \+|\-
op_mul          \*|\/
numero_int      [0-9]{1,5}
int_mto_grande  [0-9]{6,}
numero_real     [0-9]{1,6}\.[0-9]{1,6}
real_mto_grande [0-9]{6,}\.[0-9]{6,}
atribuicao      :=
intervalo_real  \[{numero_real},{numero_real}\]
char_especial   \!|\@|\#|\$|\%|\&|\§|\º|\?|\°|\ª|\{|\}
id_mal_form     {digito}({letra}|{digito})*|({letra}|{digito}|{char_especial})*
num_m_form      {digito}.({letra}|{digito}|{char_especial})+
string          (\"){letra}*(\")
char            (\'){letra}*(\')
string_m_form   (\"){letra}*|{letra}*(\")
char_m_form     (\'){letra}*|{letra}*(\')
coment          "{".*"}"

    int num_linhas = 1;


%%
program  	        {printf("%s -> programa \n", yytext); return PROGRAMA_ID;}
procedure           {printf("%s -> procedure \n", yytext); return PROCEDURE;}
const               {printf("%s -> const \n", yytext); return CONST;}
{comandos_rw}       {printf("%s -> comando \n", yytext); return RW;}
if                  {printf("%s -> comando \n", yytext); return IF;}
then                {printf("%s -> comando \n", yytext); return THEN;}
else                {printf("%s -> comando \n", yytext); return ELSE;}
var  	            {printf("%s -> var \n", yytext); return VAR;}
begin  	            {printf("%s -> begin \n", yytext); return COMECO;}
end  	            {printf("%s -> end \n", yytext); return END;}
;                   {printf("%s -> simbolo_pt_vg\n", yytext); return PV;}
=                   {printf("%s -> simbolo_igual\n", yytext); return IGUAL;}
:                   {printf("%s -> simbolo_dois_pt\n", yytext); return DP;}
\.                  {printf("%s -> simbolo_pt\n", yytext); return PF;}
,                   {printf("%s -> simbolo_vg\n", yytext); return VIRGULA;}
\(                  {printf("%s -> simbolo_abre_parenteses\n", yytext); return ABRE_P;}
\)                  {printf("%s -> simbolo_fecha_parenteses\n", yytext); return FECHA_P;}
{relacao}           {printf("%s -> op_relacional\n", yytext); return OP_RELACIONAL;}
{op_ad}             {printf("%s -> op_ad\n", yytext); return OP_AD;}
{op_mul}            {printf("%s -> op_mul\n", yytext); return OP_MUL;}
{tipo_var}  	    {printf("%s -> tipo_var \n", yytext); return TIPO_VAR;}
{coment}
{ident}             {printf("%s -> id \n", yytext); return ID;}
" "             
{numero_int}        {printf("%s -> numero_int\n", yytext); return INTEIRO;}
{numero_real}       {printf("%s -> numero_real\n", yytext); return REAL;}
{int_mto_grande}    printf("%s -> int_mto_grande (linha %d)\n", yytext, num_linhas);
{intervalo_real}    printf("%s -> intervalo_real\n", yytext);
{real_mto_grande}   printf("%s -> real_mto_grande (linha %d)\n", yytext, num_linhas);
\n                  ++num_linhas;
{char_especial}     printf("%s -> caractere_invalido (linha %d)\n", yytext, num_linhas);
{atribuicao}        {printf("%s -> atribuicao\n", yytext); return RECEBE;}
{id_mal_form}       printf("%s -> id_mal_formado (linha %d)\n", yytext, num_linhas);
{num_m_form}        printf("%s -> num_mal_formado (linha %d)\n", yytext, num_linhas);
{string}            printf("%s -> string\n", yytext);
{string_m_form}     printf("%s -> string_m_form (linha %d)\n", yytext, num_linhas);
{char}              printf("%s -> caractere\n", yytext);
{char_m_form}       printf("%s -> caractere_m_form (linha %d)\n", yytext, num_linhas);
%%
