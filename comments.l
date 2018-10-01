%{

%}
%%
"**".*			{} // remove single line comment
"{"[.\n]*"}"		{} // remove block comments
\"[.]*\"		{ printf("%s", yytext); } // print strings
.			{ printf("%s", yytext); } // print everything else
%%
int main()
{
	yylex();
	return 0;
}
