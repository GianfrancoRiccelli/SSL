%{
#include <stdio.h>
#include <stdlib.h> 
#include <math.h>
extern char *yytext;
extern int yyleng;
extern int yylex(void);
extern void yyerror(char*);
void verificarTamanioID(int tamanio);
int variable=0;
%}
%union{
   char* cadena;
   int num;
} 
%token ASIGNACION PYCOMA SUMA RESTA PARENIZQUIERDO PARENDERECHO COMA INICIO FIN LEER ESCRIBIR
%token <cadena> ID
%token <num> CONSTANTE

%start programa

%%

programa: INICIO listaSentencias FIN
;
listaSentencias: sentencia 
|listaSentencias sentencia
;
sentencia: ID {verificarTamanioID(yyleng);} ASIGNACION expresion PYCOMA
|LEER PARENIZQUIERDO listaIdentificadores PARENDERECHO PYCOMA
|ESCRIBIR PARENIZQUIERDO listaExpresiones PARENDERECHO PYCOMA
;
listaIdentificadores: ID
| listaIdentificadores COMA ID
;
listaExpresiones: expresion
|listaExpresiones COMA expresion
;
expresion: primaria 
|expresion operadorAditivo primaria 
; 
primaria: ID
|CONSTANTE
|PARENIZQUIERDO expresion PARENDERECHO
;
operadorAditivo: SUMA 
| RESTA
;
%%
int main() {
yyparse();
}
void verificarTamanioID(int tamanio){
  if(tamanio>32) yyerror("Se excedio el tamanio maximo de caracteres para un ID (32)");

}
void yyerror (char *s){
printf ("%s\n",s);
}
int yywrap()  {
  return 1;  
} 
