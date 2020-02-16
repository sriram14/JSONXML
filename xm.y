%{
    #include<stdio.h>
    int yylex();
    void yyerror(const char *);
    
%}

%union {
    char *str;
}

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

start : OP_BRAC CON KEYVAL CL_BRAC | OP_BRAC CL_BRAC

CON : CON KEYVAL COMMA |

KEYVAL : KEY COLON VAL 

KEY : QUOT VALID QUOT

VAL : QUOT STRING QUOT
     | NUM
     | BTRUE
     | BFALSE
     | start
     | ARRVAL

STRING :  STRING TEXT
        | STRING NUM
        | STRING COLON
        | TEXT
        | NUM
        | COLON

ARRVAL : OP_ABRAC CONVAL VAL CL_ABRAC | OP_ABRAC CL_ABRAC

CONVAL : CONVAL VAL COMMA | ;

VALID : VALID TEXT
       | VALID NUM
       | TEXT

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