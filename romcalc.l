%{
#include <stdio.h>
#include "romcalc.tab.h"
%}
%%
"+"		{ return ADD; }
"-"		{ return SUB; }
"/"		{ return DIV; }
"*"		{ return MUL; }
"{"		{ return OP; }
"}"		{ return CP; }
I		{ return ONE; }
V 		{ return FIVE; }
X		{ return TEN; }
L 		{ return FIFTY; }
C 		{ return HUNDRED; }
D 		{ return FIVEHUNDRED; }
M 		{ return THOUSAND; }
\n		{ return EOL; }
[ \t]*		{ }
.		{ yyerror(); }
%%
/*int main()
{
	yylex();
	return 0;
}*/
