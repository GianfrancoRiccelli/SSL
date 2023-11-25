%{
#include <stdio.h>
#include <stdlib.h>	
#include <string.h>
#include "y.tab.h"

void errorLexico(void);


%}

separador		[ \t]+
DIGITO			[0-9]
LETRA			[a-zA-Z]
IDENTIFICADOR	{LETRA}({LETRA}|{DIGITO})*
constEntera {DIGITO}({DIGITO})*
%%
{separador}     {}/* Se ignoran */

"inicio"        {return INICIO;}
"fin"           {return FIN;}
"leer"          {return LEER;}
"escribir"      {return ESCRIBIR;}

{constEntera} {yylval.num=atoi(yytext);return CONSTANTE;}
{IDENTIFICADOR} {return ID;}
":="            {return ASIGNACION;}
","             {return COMA;}
";"             {return PYCOMA;}
"+"             {return SUMA;}
"-"             {return RESTA;}
"("             {return PARENIZQUIERDO;}
")"             {return PARENDERECHO;}
.				{errorLexico();}
%%
void errorLexico(void){
   printf("Error lexico, se ha ingresado un caracter invalido (%s).\n", yytext);
}
