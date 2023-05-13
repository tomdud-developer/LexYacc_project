%{
	#include <stdio.h>

	void yyerror(char *s);
	int yylex();
	extern FILE* yyin;
%}


%token LICZBA

%%
program: program wyrazenie '\n' {
	printf("Wynik  =  %d\n\n",  $2);
}
	|
	;
wyrazenie: LICZBA { $$ = $1; }
	| wyrazenie '+' wyrazenie  { $$ = $1 + $3; }
	| wyrazenie '-' wyrazenie  { $$ = $1 -$3; }
	| '(' wyrazenie ')'{ $$ = $2; } 
	|
	;
	
%%

void yyerror(char *s)
{
	fprintf(stderr, "%s\n", s);
}

int main(void)
{

        yyin = fopen("input.text", "r");
	yyparse();
	fclose(yyin);   
	
	return 0;
}

