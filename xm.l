%{
%}

TEXT [a-zA-Z']+
NUM [0-9]+
SPACE " "
COLON :
COMMA ","

%%

"true" { return BTRUE;}
"false" {return BFALSE;}
"\"" { printf("\nQuotation"); return QUOT;} 
"{" { printf("\nOP BRAC"); return OP_BRAC;}
"}" { printf("\nCLOSE BRAC"); return CL_BRAC;}
"[" { printf("\nOP BRAC"); return OP_ABRAC;}
"]" { printf("\nCLOSE BRAC"); return CL_ABRAC;}
{COLON} { printf("\nvalue is %s",yytext); return COLON;}
{TEXT} { printf("\nTEXT is %s",yytext); return TEXT;}
{NUM}|{NUM}.{NUM} { printf("\nNUM is %s",yytext); return NUM;}
{COMMA} { printf("\nComma"); return COMMA; }

%%