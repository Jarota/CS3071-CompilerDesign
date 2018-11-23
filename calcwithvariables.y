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

valid: VAR ASSIGN expr SC	{}
| PRINT VAR SC			{}
;

expr:

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
