%{
%}

QUOT "\""
TEXT [a-zA-Z]   
NUM [0-9]
SPACE " "
VAL :
COMMA ","

%%

{QUOT} { printf("\nQuotation"); } 
"{" { printf("\nOP BRAC"); }
"}" { printf("\nCLOSE BRAC"); }
{VAL} { printf("\nvalue is %s",yytext); }
{TEXT} { printf("\nTEXT is %s",yytext); }
{NUM} { printf("\nNUM is %s",yytext); }
{COMMA} { printf("\nComma"); } 
%%