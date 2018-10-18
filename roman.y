%{
#  include <stdio.h>
#  include <stdlib.h>
void yyerror(char *s);
int yylex();
int yyparse();
%}
%output "brackets.c"

%token I V X L C D M EOL
%%


%%
void yyerror(char *s)
{
  printf("error: %s\n", s);
}


int main()
{
//  yydebug = 1;
  yyparse();
  return 0;
}
