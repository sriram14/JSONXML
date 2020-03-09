%{
    #include<stdio.h>
    #include<string.h>
    int yylex();
    void yyerror(const char *);
%}

%union {
    char *str;
}

%token QUOT
%token COMMA
%token OP_BRAC
%token CL_BRAC
%token OP_ABRAC
%token CL_ABRAC
%token  COLON


%token <str> STEXT
%token <str> ETEXT
%token <str> TEXT
%token <str> NUM
%token <str> BTRUE
%token <str> BFALSE
%token <str> SPACE

%type <str> string
%type <str> valid
%type <str> val
%type <str> key
%type <str> conval
%type <str> keyval
%type <str> con
%type <str> start

%error-verbose

%%

start : arrval{} | keyvalstart {}

keyvalstart: OP_BRAC con keyval CL_BRAC {} | OP_BRAC CL_BRAC {}

con : con keyval COMMA {} | {}

keyval : key COLON val {printf("</%s>",$1);}     

key : QUOT valid QUOT { $$=$2; printf("<%s>",$2);}

val : QUOT string QUOT {printf("%s",$2);}
     | QUOT QUOT {}
     | NUM {printf("%s",$1);}
     | BTRUE {printf("%s",$1);}
     | BFALSE {printf("%s",$1);}
     | keyvalstart {}
     | arrval {}

string :  string STEXT {strcat($1,$2); $$=$1;}
        | string ETEXT {strcat($1,$2); $$=$1;}
        | string TEXT  {strcat($1,$2); $$=$1;}
        | string NUM {strcat($1,$2); $$=$1;}
        | string COLON {char col[]=":";strcat($1,col); $$=$1;}
        | string COMMA {char comm[]=",";strcat($1,comm); $$=$1;}
        | TEXT {$$=$1;}
        | STEXT {$$=$1;}
        | COMMA {$$=",";}
        | ETEXT {$$=$1;}
        | NUM {$$=$1;}
        | COLON { $$=":";}

arrval :  OP_ABRAC conval val CL_ABRAC {printf("</element>");}
        | OP_ABRAC CL_ABRAC {}
       
conval :  conval val COMMA {printf("</element>");printf("<element>"); }
        | {printf("<element>");}
        
valid : valid TEXT {strcat($1,$2); $$=$1;}
       | valid NUM {strcat($1,$2); $$=$1;} 
       | TEXT { $$=$1;}
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