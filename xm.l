%{
%}

TEXT [a-zA-Z'/!@#$%^&*()_+\-\+=\|?></\.;]+
NUM [0-9]+

%%

"true" { return BTRUE;}
"false" {return BFALSE;}
"\"" {  return QUOT;} 
"{" {  return OP_BRAC;}
"}" {  return CL_BRAC;}
"[" {  return OP_ABRAC;}
"]" {  return CL_ABRAC;}
":" {  return COLON;}
{TEXT} { return TEXT;}
{NUM}|{NUM}.{NUM} {  return NUM;}
"," {  return COMMA; }

%%