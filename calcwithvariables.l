%{
#include <stdio.h>
#include "calcwithvariables.tab.h"
%}
%%
":="		{ return ASSIGN; }
"print "	{ return PRINT; }
[0-9]		{ return NUM; }
[a-z]		{ return VAR; }
"+"		{ return ADD; }
"-"		{ return SUB; }
"/"		{ return DIV; }
"*"		{ return MUL; }
";"		{ return SC; }
[ \t\n]*	{ /* ignore whitespace */ }
.		{ yyerror(); }
%%
