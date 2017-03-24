/*
Kollins Gabriel Lima
*/

programa	program {ident}; {corpo}
ident		letra(letra|digito)*
corpo		{dc} begin {comandos} end
dc		    {dc_c}{dc_v}{dc_p}
dc_c		const {ident} = {numero};{dc_c}
dc_v		var {variaveis}:{tipo_var};{dc_v}
tipo_var	real|integer
variaveis	ident {mais_var}
mais_var	, {variaveis}
dc_p		procedure {ident} {parametros};{corpo_p}{dc_p}
parametros	({lista_par})
lista_par	{variaveis}:{tipo_var}{mais_par}
mais_par	; {lista_par}
corpo_p		{dc_loc} begin {comandos} end;

%%
{tipo_var}	printf("%s - tipo_var", yytext);
.		printf("%s - NADA!", yytext);
%%

int main(int argc, char *argv[])
{
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
}
