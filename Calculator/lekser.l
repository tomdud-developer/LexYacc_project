%option noyywrap
%{
	#include <stdlib.h>
	#include "parser.y"
%}

%%
[0-9]+        {yylval = atoi(yytext); return LICZBA;}
"-"            return '-';
[+()]          return yytext[0];
[\n]           return '\n';
%%
