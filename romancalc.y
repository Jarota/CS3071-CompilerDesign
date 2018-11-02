%{
#  include <stdio.h>
#  include <stdlib.h>
void yyerror();
int yylex();
int yyparse();
%}


%token ADD SUB DIV MUL OP CP ONE FIVE TEN FIFTY HUNDRED FIVEHUNDRED THOUSAND EOL
%%
valid: lowprecedence EOL	{}
| valid lowprecedence EOL
;

lowprecedence: highprecedence ADD highprecedence	{ $$ = $1 + $3; }
| highprecedence SUB highprecedence			{ $$ = $1 - $3; }
| highprecedence					{ $$ = $1; }
;

highprecedence: number DIV number		{ $$ = $1 / $3; }
| number MUL number				{ $$ = $1 * $3; }
| number					{ $$ = $1; }
;

number: thousands 	{ $$ = $1; }
;

thousands: THOUSAND fivehundreds		{ $$ = 1000 + $2; }
| THOUSAND THOUSAND fivehundreds		{ $$ = 2000 + $3; }
| THOUSAND THOUSAND THOUSAND fivehundreds	{ $$ = 3000 + $4; }
| fivehundreds					{ $$ = $1; }
;

fivehundreds: FIVEHUNDRED hundreds	{ $$ = 500 + $2; }
| HUNDRED FIVEHUNDRED fifties		{ $$ = 400 + $3; }
| HUNDRED THOUSAND fifties		{ $$ = 900 + $3; }
| hundreds				{ $$ = $1; }
;

hundreds: HUNDRED fifties		{ $$ = 100 + $2; }
| HUNDRED HUNDRED fifties		{ $$ = 200 + $3; }
| HUNDRED HUNDRED HUNDRED fifties	{ $$ = 300 + $4; }
| fifties				{ $$ = $1; }
;

fifties: FIFTY tens	{ $$ = 50 + $2; }
| TEN FIFTY fives	{ $$ = 40 + $3; }
| TEN HUNDRED fives	{ $$ = 90 + $3; }
| tens			{ $$ = $1; }
;

tens: TEN fives		{ $$ = 10 + $2; }
| TEN TEN fives		{ $$ = 20 + $3; }
| TEN TEN TEN fives	{ $$ = 30 + $4; }
| fives			{ $$ = $1; }
;

fives: FIVE ones	{ $$ = 5 + $2; }
| ONE FIVE		{ $$ = 4; }
| ONE TEN		{ $$ = 9; }
| ones			{ $$ = $1; }
;

ones: /* NOTHING */	{ $$ = 0; }
| ONE			{ $$ = 1; }
| ONE ONE		{ $$ = 2; }
| ONE ONE ONE		{ $$ = 3; }
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
