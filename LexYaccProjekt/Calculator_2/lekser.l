%option noyywrap
%{
	#include <stdlib.h>
	#include "parser.tab.h"
%}

%%
[a-z]         { yylval.ctype = yytext[0]; return VARIABLE; }
"-"           return '-';
"+"           return '+';
"/"           return '/';
"*"           return '*';
"="           return '=';
[()]          return yytext[0];
[\n]          return '\n';
[0-9]+        { yylval.dtype = atoi(yytext); return NUMBER; }

%%

