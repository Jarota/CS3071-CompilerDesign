%{
#include <stdio.h>
#include "calcwithvariables.tab.h"
%}
%%
":="		{ return ASSIGN; }
"print "	{ return PRINT; }
[0-9]		{ yylval = atoi(yytext); return NUM; }
[a-z]		{ yylval = yytext[0]; return VAR; }
"+"		{ return ADD; }
"-"		{ return SUB; }
"/"		{ return DIV; }
"*"		{ return MUL; }
";"		{ return SC; }
[ \t\n]*	{ /* ignore whitespace */ }
.		{ yyerror(); }
%%
