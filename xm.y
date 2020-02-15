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

start : OP_BRAC CON CL_BRAC { printf("\nMatched");} 

CON : OP_ABRAC start CL_ABRAC
      | CON KEYVAL COMMAS {printf("\nCONS ET");}
      | {printf("\nCONS");}

KEYVAL : KEY COLON VAL { printf("\nasasas");}

COMMAS : COMMA | ;

KEY : QUOT VALID QUOT { printf("\nKey");}

VAL : QUOT VALID QUOT
     | QUOT NUM VALID QUOT
     | QUOT NUM QUOT
     | NUM
     | BTRUE
     | BFALSE
     | start {printf("\nBLOOPBLOOP");}
 

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