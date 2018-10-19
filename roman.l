%{
#include <stdio.h>
#include "roman.tab.h"
%}
%%
I		{ return ONE; }
V 		{ return FIVE; }
X		{ return TEN; }
L 		{ return FIFTY; }
C 		{ return HUNDRED; }
D 		{ return FIVEHUNDRED; }
M 		{ return THOUSAND; }
\n		{ return EOL }
.		{ yyerror("syntax error\n"); exit(0); }
%%
int main()
{
	yylex();
	return 0;
}
