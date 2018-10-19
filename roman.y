%{
#  include <stdio.h>
#  include <stdlib.h>
void yyerror(char *s);
int yylex();
int yyparse();
%}
%output "brackets.c"

%token ONE FIVE TEN FIFTY HUNDRED FIVEHUNDRED THOUSAND EOL
%%
number: thousands EOL { $$ = $1; printf("%d\n", $$); }
;

thousands: THOUSAND fivehundreds		{ $$ = 1000 + $2; }
| THOUSAND THOUSAND fivehundreds		{ $$ = 2000 + $2; }
| THOUSAND THOUSAND THOUSAND fivehundreds	{ $$ = 3000 + $2; }
| FIVEHUNDRED THOUSAND fifties			{ $$ = 900 + $2; }
| fivehundreds					{ $$ = $1; }
;

fivehundreds: FIVEHUNDRED hundreds	{ $$ = 500 + $2; }
| HUNDRED FIVEHUNDRED fifties		{ $$ = 400 + $2; }
| hundreds				{ $$ = $1; }
;

hundreds: HUNDRED fifties		{ $$ = 100 + $2; }
| HUNDRED HUNDRED fifties		{ $$ = 200 + $2; }
| HUNDRED HUNDRED HUNDRED fifties	{ $$ = 300 + $2; }
| TEN HUNDRED fives			{ $$ = 90 + $2; }
| fifties				{ $$ = $1; }
;

fifties: FIFTY tens	{ $$ = 50 + $2; }
| TEN FIFTY fives	{ $$ = 40 + $2; }
| tens			{ $$ = $1; }
;

tens: TEN fives		{ $$ = 10 + $2; }
| TEN TEN fives		{ $$ = 20 + $2; }
| TEN TEN TEN fives	{ $$ = 30 + $2; }
| ONE TEN		{ $$ = 9; }
| fives			{ $$ = $1; }
;

fives: FIVE ones	{ $$ = 5 + $2; }
| ONE FIVE		{ $$ = 4; }
| ones			{ $$ = $1; }
;

ones: /* NOTHING */	{ $$ = 0; }
| ONE			{ $$ = 1; }
| ONE ONE		{ $$ = 2; }
| ONE ONE ONE		{ $$ = 3; }
;
%%
void yyerror(char *s)
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
