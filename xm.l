%{

%}

TEXT [a-zA-Z'/!@#$%^&*()_+\-\+=\|?></\.;]+
NUM [0-9]+

%%

"true" { yylval.str = strdup(yytext); return BTRUE;}
"false" { yylval.str = strdup(yytext); return BFALSE;}
"\"" {  return QUOT;} 
"{" {  return OP_BRAC;}
"}" {  return CL_BRAC;}
"[" {  return OP_ABRAC;}
"]" {  return CL_ABRAC;}
":" {   return COLON;}
{TEXT} { yylval.str = strdup(yytext); return TEXT;}
{TEXT}" " { yylval.str = strdup(yytext); return ETEXT;}
" "{TEXT} { yylval.str = strdup(yytext); return STEXT;}
{NUM}|{NUM}"."{NUM} {  yylval.str = strdup(yytext); return NUM;}
"," {  return COMMA; }
%%