%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "pruebaBison.tab.h"
	
	void errorLexico();
%}
DIGITO [0-9]

LETRA [a-zA-Z]

IDENTIFICADOR {LETRA}({LETRA}|{DIGITO})*
separador [\t]+
constEntera {DIGITO}({DIGITO})*
%%
"inicio" {return (INICIO);}
"fin" {return (FIN);}
"leer" {return (LEER);}
"escribir" {return (ESCRIBIR);}
":=" {return (ASIGNACION);}
{constEntera} {yylval.num=atoi(yytext);return (CONSTANTE);}
{IDENTIFICADOR} {return (ID);}
{separador}     {}
";" {return (PYCOMA);}
"," {return (COMA);}
"(" {return (PARENIZQUIERDO);}
")" {return (PARENDERECHO);}
"+" {return (SUMA);}
"-" {return (RESTA);}
. {errorLexico();}
%% 
void errorLexico(){
    printf("Error Lexico: se ha ingresado un caracter invalido (%s)\n", yytext);
}
