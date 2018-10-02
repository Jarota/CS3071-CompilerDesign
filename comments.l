%{
int comment = 0;
%}
%%
"**".*			{} // remove single line comment
\".*\"			{ printf("%s", yytext); } // print strings
"{"			{ comment = 1; } // start block comments
"}"			{ if(comment == 0){ printf("syntax error\n"); return 0; } comment = 0; } // end block comments
.			{ if(comment == 0){ printf("%s", yytext); } }
\n			{ if(comment == 0){ printf("%s", yytext); } }

%%
int main()
{
	yylex();
	if(comment == 1) printf("syntax error\n");
	return 0;
}
