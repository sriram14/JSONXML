%{
    #include<stdio.h>
    int yylex();
    void yyerror(const char *);
    
%}

%token QUOT
%token TEXT
%token NUM
%token SPACE
%token BTRUE
%token BFALSE
%token COLON
%token COMMA
%token OP_BRAC
%token CL_BRAC
%token OP_ABRAC
%token CL_ABRAC
%error-verbose

%%

start : OP_BRAC CON CL_BRAC

CON : CON KEYVAL COMMAS
    |

KEYVAL : KEY COLON VAL 

COMMAS : COMMA | 

KEY : QUOT VALID QUOT

VAL : QUOT VALID QUOT
     | QUOT NUM VALID QUOT
     | QUOT NUM QUOT
     | NUM
     | BTRUE
     | BFALSE
     | start
     | ARRVAL

ARRVAL : OP_ABRAC CONVAL CL_ABRAC

CONVAL: CONVAL VAL COMMAS | ;

VALID : VALID TEXT {};
       | VALID NUM {};
       | TEXT {};

%%
  
#include "lex.yy.c"  
   
int main(){
    return yyparse();
}
void yyerror(const char * s) 
{    
    fprintf (stderr, "%s\n", s); 
}  

int yywrap()
{
    return(1);
}