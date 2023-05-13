/* the "INCLUDE" state is used for picking up the name
* of an include file
*/

%option noyywrap 

%x INCLUDE

%{
#include <iostream>

using namespace std;

#define MAX_INCLUDE_DEPTH 10
YY_BUFFER_STATE include_stack[MAX_INCLUDE_DEPTH];
int include_stack_ptr = 0;

long word_counter = 0L;
long sentence_counter = 0L;
	
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
"include"           BEGIN(INCLUDE);
[a-zA-Z]+           ECHO;
[0-9]+              ECHO;
[^a-z\n]*\n?        ECHO;

<INCLUDE>[ \t]*      /* eat the whitespace */
<INCLUDE>[^ \t\n]+   { /* got the include file name */
	if (include_stack_ptr >= MAX_INCLUDE_DEPTH)
		{
			fprintf( stderr, "Includes nested too deeply" );
			exit( 1 );
		}
	include_stack[include_stack_ptr++] = YY_CURRENT_BUFFER;
	
	yytext[strlen(yytext) - 2] = NULL;
	char* file_name = yytext + 1;
	
	std::cout << "Try open a file, name =" << file_name << endl;
	
	yyin = fopen( file_name, "r" );
	
	if ( ! yyin ) {
		std::cout << "Error open a file, name =" << file_name << endl;
		exit(-55);
	}
		
	yy_switch_to_buffer( yy_create_buffer( yyin, YY_BUF_SIZE ) );
	
	BEGIN(INITIAL);
}

<<EOF>> {
	if ( --include_stack_ptr == 0 )
		{
			yyterminate();
		}
	else
		{
			yy_delete_buffer( YY_CURRENT_BUFFER );
			yy_switch_to_buffer(
			include_stack[include_stack_ptr] );
		}
}

%%

int main(int argc, char** argv) 
{
	yyin = fopen("p.tex", "r");
	yylex();
	

	fclose(yyin);   
	return 0;
}
