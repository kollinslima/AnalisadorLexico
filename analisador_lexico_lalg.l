/*
Afonso Henrique da Silva - 8910347
Kollins Gabriel Lima - 9012931
*/

letra           [a-z]|[A-Z]
digito          [0-9]
ident		    {letra}({letra}|{digito})*|_({letra}|{digito})*
tipo_var	    real|integer
comandos        read|write|if|then|else
relacao         =|<>|>=|>|<
op_ad           \+|\-
op_mul          \*|\/
numero_int      [0-9]+
numero_real     [0-9]+\.[0-9]+
atribuicao      :=
intervalo_real  \[{numero_real},{numero_real}\]
char_especial   \!|\@|\#|\$|\%|\&|\§|\º|\?|\°|\ª
id_mal_form     {digito}({letra}|{digito})*|({letra}|{digito}|{char_especial})*
num_m_form      {digito}.({letra}|{digito}|{char_especial})+
string          (\"){letra}*(\")
char            (\'){letra}*(\')
string_m_form   (\"){letra}*|{letra}*(\")
char_m_form     (\'){letra}*|{letra}*(\')
coment          "{".*"}"

    int num_linhas = 1;


%%
program  	    printf("%s -> programa \n", yytext);
{comandos}      printf("%s -> comando \n", yytext);
var  	        printf("%s -> var \n", yytext);
begin  	        printf("%s -> begin \n", yytext);
end  	        printf("%s -> end \n", yytext);
;               printf("%s -> simbolo_pt_vg\n", yytext);
:               printf("%s -> simbolo_dois_pt\n", yytext);
\.              printf("%s -> simbolo_pt\n", yytext);
,               printf("%s -> simbolo_vg\n", yytext);
\(              printf("%s -> simbolo_abre_parenteses\n", yytext);
\)              printf("%s -> simbolo_fecha_parenteses\n", yytext);
{relacao}       printf("%s -> op_relacional\n", yytext);
{op_ad}         printf("%s -> op_ad\n", yytext);
{op_mul}        printf("%s -> op_mul\n", yytext);
{tipo_var}  	printf("%s -> tipo_var \n", yytext);
{coment}
{ident}         printf("%s -> id \n", yytext);
" "             
{numero_int}    printf("%s -> numero_int\n", yytext);
{numero_real}   printf("%s -> numero_real\n", yytext);
{intervalo_real} printf("%s -> intervalo_real\n", yytext);
\n              ++num_linhas;
{char_especial} printf("%s -> caractere_invalido (linha %d)\n", yytext, num_linhas);
{atribuicao}    printf("%s -> atribuicao\n", yytext);
{id_mal_form}   printf("%s -> id_mal_formado (linha %d)\n", yytext, num_linhas);
{num_m_form}    printf("%s -> num_mal_formado (linha %d)\n", yytext, num_linhas);
{string}        printf("%s -> string\n", yytext);
{string_m_form} printf("%s -> string_m_form (linha %d)\n", yytext, num_linhas);
{char}          printf("%s -> caractere\n", yytext);
{char_m_form}   printf("%s -> caractere_m_form (linha %d)\n", yytext, num_linhas);
%%

int main(int argc, char *argv[])
{
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
}
