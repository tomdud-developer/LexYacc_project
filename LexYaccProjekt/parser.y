
%{
	#include <stdlib.h>
	#include <stdio.h>
	#include <iostream>
	
	void yyerror(char *s);
	int yylex();
	extern FILE* yyin;

   int licznik = 0;
	
%}

%verbose 

%token ID BYE
	
%%

head : head BYE     {  
                       std::cout << "czesc" << std::endl;  
                       return 0;
                    }
     | head ID      {  std::cout << ++licznik << " "; }             
     | 

	
%%

void yyerror(char *s) 
{
    fprintf(stderr, "%s\n", s);
}

int main() 
{
    std::ios_base::sync_with_stdio (true);
    yyparse();    
    return 0;
}
