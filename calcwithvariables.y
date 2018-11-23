%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror();
int yylex();
int yyparse();

int variables[26];

%}


%token ASSIGN PRINT NUM VAR ADD SUB DIV MUL SC
%%
valid: stmt
| valid stmt
;

stmt: VAR ASSIGN low SC	{ variables[$1-97] = $3; }
| PRINT VAR SC		{ printf("%d\n", variables[$2-97]); }
;

low: low ADD high	{ $$ = $1 + $3; }
| low SUB high		{ $$ = $1 - $3; }
| high			{ $$ = $1; }
;

high: high MUL operand	{ $$ = $1 * $3; }
| high DIV operand	{ $$ = $1 / $3; }
| operand		{ $$ = $1; }
;

operand: SUB value	{ $$ = (-1) * $2; }
| value			{ $$ = $1; }
;

value: VAR		{ $$ = variables[$1-97]; }
| NUM			{ $$ = $1; }
;

%%
void yyerror()
{
  printf("syntax error\n");
  exit(0);
}

int main()
{
//  yydebug = 1;
  yyparse();
  return 0;
}
