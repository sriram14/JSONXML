%{
%}

TEXT [a-zA-Z'/!@#$%^&*()_+\-\+=\|?></\.;]+
NUM [0-9]+
SPACE " "
COLON :
COMMA ","

%%

"true" { return BTRUE;}
"false" {return BFALSE;}
"\"" {  return QUOT;} 
"{" {  return OP_BRAC;}
"}" {  return CL_BRAC;}
"[" {  return OP_ABRAC;}
"]" {  return CL_ABRAC;}
{COLON} {  return COLON;}
{TEXT} { return TEXT;}
{NUM}|{NUM}.{NUM} {  return NUM;}
{COMMA} {  return COMMA; }

%%