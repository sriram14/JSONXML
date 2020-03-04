%{
    #include<stdio.h>
    #include<string.h>
    int yylex();
    void yyerror(const char *);
%}

%union {
    char *str;
    int n;
}

%token QUOT
%token COMMA
%token OP_BRAC
%token CL_BRAC
%token OP_ABRAC
%token CL_ABRAC


%token <str> STEXT
%token <str> TEXT
%token <str> NUM
%token  COLON
%token <str> BTRUE
%token <str> BFALSE
%token <str> SPACE

%type <str> STRING
%type <str> VALID
%type <str> VAL
%type <str> KEY
%type <str> CONVAL
%type <str> KEYVAL
%type <str> CON
%type <str> start


%error-verbose

%%

start : OP_BRAC CON KEYVAL CL_BRAC {} | OP_BRAC CL_BRAC {}

CON : CON KEYVAL COMMA {} | {}

KEYVAL : KEY COLON VAL {printf("</%s>",$1);}     

KEY : QUOT VALID QUOT { $$=$2; printf("<%s>",$2);}

VAL : QUOT STRING QUOT {printf("%s",$2);}
     | QUOT QUOT {}
     | NUM {printf("%s",$1);}
     | BTRUE {printf("%s",$1);}
     | BFALSE {printf("%s",$1);}
     | start {}
     | ARRVAL {}

STRING :  STRING STEXT {strcat($1,$2); $$=$1;}
        | STRING TEXT  {strcat($1,$2); $$=$1;}
        | STRING NUM {strcat($1,$2); $$=$1;}
        | STRING COLON {char col[]=":";strcat($1,col); $$=$1;}
        |  TEXT {$$=$1;}
        |  STEXT {$$=$1;}
        | NUM {$$=$1;}
        | COLON { $$=":";}

ARRVAL :  OP_ABRAC CONVAL VAL CL_ABRAC {printf("</element>");}
        | OP_ABRAC CL_ABRAC {}
       
CONVAL :  CONVAL VAL COMMA {printf("</element>");printf("<element>"); }
        | {printf("<element>");}
        
VALID : VALID TEXT {}
       | VALID NUM {} 
       | TEXT {}
%%
  
#include "lex.yy.c"  
   
int main(){
    printf("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<root>");
    int x =yyparse();
    printf("</root>");
    return x;
}
void yyerror(const char * s) 
{    
    fprintf (stderr, "%s\n", s); 
}  

int yywrap()
{
    return(1);
}