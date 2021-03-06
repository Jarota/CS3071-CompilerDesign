%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror();
int yylex();
int yyparse();

void intToRoman(int x, char* result);

%}


%token ADD SUB DIV MUL OP CP ONE FIVE TEN FIFTY HUNDRED FIVEHUNDRED THOUSAND EOL
%%
valid: lowprecedence EOL	{ char romanNumeral[50]; intToRoman($1, romanNumeral); printf("%s\n", romanNumeral); }
| valid lowprecedence EOL	{ char romanNumeral[50]; intToRoman($2, romanNumeral); printf("%s\n", romanNumeral); }
;

lowprecedence: lowprecedence ADD highprecedence		{ $$ = $1 + $3; }
| lowprecedence SUB highprecedence			{ $$ = $1 - $3; }
| highprecedence					{ $$ = $1; }
;

highprecedence: highprecedence DIV operand	{ $$ = $1 / $3; }
| highprecedence MUL operand			{ $$ = $1 * $3; }
| operand					{ $$ = $1; }
;

operand: number		{ $$ = $1; }
| OP lowprecedence CP	{ $$ = $2; }
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

void intToRoman(int x, char* result)
{
	if ( x == 0 ) {
		*result++ = 'Z';
		return;
	}
	if ( x < 0 ) {
		*result++ = '-';
		x *= -1;
	}

	char *huns[] = {"", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"};
	char *tens[] = {"", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"};
	char *ones[] = {"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"};
	int   size[] = { 0,   1,    2,     3,    2,   1,    2,     3,      4,    2};

	while (x >= 1000) {
		*result++ = 'M';
		x -= 1000;
	}

	strcpy (result, huns[x/100]); result += size[x/100]; x = x % 100;
	strcpy (result, tens[x/10]);  result += size[x/10];  x = x % 10;
	strcpy (result, ones[x]);     result += size[x];

	*result++ = '\0';

}

int main()
{
//  yydebug = 1;
  yyparse();
  return 0;
}
