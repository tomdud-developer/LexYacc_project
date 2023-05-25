
%option noyywrap 

DIGIT [0-9]{1,3}	

EMAIL_FIRST_SECTION ([a-z]|[A-Z]|_)([a-z]|[A-Z]|_|[0-9]*)   
EMAIL_SUBDOMAIN_SECTION ([a-z]{2,6})
EMAIL_DOMAIN_SECTION ([a-z]|[A-Z])
EMAIL_DOMAIN_SECTION3 ([a-z]|[A-Z])
%{
	
	#include <iostream>
   	
	using namespace std;
	
#ifdef _WIN32
    // needed by Visual Studio compiler:
	int isatty (int a)  // is deprecated, use _isatty instead
	{
	    return _isatty(a);
	}
	
	int fileno (FILE * f)
	{
	    return _fileno(f);
	}
#endif
	
#define DEBUG(x)  cerr << __FILE__ << " (" << __LINE__ << ") " << #x << " == " << x << endl;	
   

%}
 

 

%%

^{DIGIT}\.{DIGIT}\.{DIGIT}\.{DIGIT} {
	cout << yytext << endl;
}

^{EMAIL_FIRST_SECTION}@{EMAIL_DOMAIN_SECTION} {
	cout << yytext << endl;
}                               

						
(19(0[1-9]|[1-9][0-9]))|2000              {  
                                             cout << "wiek XX, rok " << yytext << endl;
                                          }
                                          
bye                                       {  return 0; }
.                                         {  /* inne znaki usuwamy */ }



%%

 

int main(int argc, char** argv) 
{
	yyin = fopen("text.txt", "r");
	yylex();
	std::cout << "End of program." << endl;
	fclose(yyin);   
    return 0;
}

 
