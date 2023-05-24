%{
	#include <stdio.h>
	#include <stdlib.h>

	void yyerror(const char *s);
	int yylex();
	extern FILE* yyin;
%}

%token NUMBER

%%
program: program expression '\n' {
	printf("Wynik  =  %d\n\n", $2);
}
	|
	;
expression: NUMBER { $$ = $1; }
	| expression '+' expression  { $$ = $1 + $3; }
	| expression '-' expression  { $$ = $1 - $3; }
	| '(' expression ')' { $$ = $2; } 
	|
	;
	
%%

void yyerror(const char *s)
{
	fprintf(stderr, "%s\n", s);
}

int main(void)
{
	yyin = fopen("input.txt", "r");
	yyparse();
	fclose(yyin);   
	
	return 0;
}
