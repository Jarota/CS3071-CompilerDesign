%{
char* outputString = "";
%}
%%
"**"[.]*$	{} // remove single line comment

[a-zA-Z]+	{}
\n		{}
.		{}
%%
int main()
{
	yylex();
	printf("%d\n", outputString);
	return 0;
}
