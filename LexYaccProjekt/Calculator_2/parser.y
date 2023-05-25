%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <map>
	#include <iostream>

	void yyerror(const char *s);
	int yylex();
	extern FILE* yyin;
	std::map<int, double> variables;
%}
%union
{
	double dtype;
	char ctype;
}
%token <dtype>NUMBER
%token <ctype>VARIABLE

%type <dtype>program
%type <dtype>expression

%%
program: program expression '\n' {
	std::cout << "Size of map: " << variables.size() << std::endl;
	printf("Wynik  =  %lf\n", $2);
}
	|
	;
expression: NUMBER { $$ = $1; }
	| VARIABLE '=' NUMBER        { $$ = $3; variables[(int)$1] = $3; }
	| VARIABLE                   { 
									if(variables[(int)$1] == NULL) {
										yyerror("Variable not found ERROR!");
										exit(-1);
									}
									$$ = variables[(int)$1]; 
								 }
	| expression '+' expression  { $$ = $1 + $3; }
	| expression '-' expression  { $$ = $1 - $3; }
	| expression '/' expression  { $$ = $1 / $3; }
	| expression '*' expression  { $$ = $1 * $3; }
	| '(' expression ')' { $$ = $2; } 
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
	printf("End of Program\n");
	return 0;
}
