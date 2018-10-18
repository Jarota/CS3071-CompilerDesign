%{

%}
%%
"I" 	{ return I; }
"V" 	{ return V; }
"X" 	{ return X; }
"L" 	{ return L; }
"C" 	{ return C; }
"D" 	{ return D; }
"M" 	{ return M; }
\n	{ return EOL }
.	{ yyerror("Mystery character\n"); }
%%
int main()
{
	yylex();
	return 0;
}
