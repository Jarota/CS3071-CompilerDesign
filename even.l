%{
int count = 0;
%}
%%
[0-9]*[02468][ \t\n\r\f\v]+	{ count++; }
[a-zA-Z]+	{}
\n		{}
.		{}
%%
int main()
{
	yylex();
	printf("%d\n", count);
	return 0;
}
