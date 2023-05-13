
 


%option noyywrap

%{
   #include <stdlib.h> 
   #include <iostream>
	#include "parser.tab.h"
%}
 
%%

bye            return BYE;
[a-z]+         return ID;
.              /* pozostale znaki usun */
              

%%
