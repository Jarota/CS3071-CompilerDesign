%{

%}

YEAR	[0-9]{2}[12]?
COUNTY	C | CE | CN | CW | D | DL | G | KE | KK | KY | L | LD | LH | LM | LS | MH | MN | MO | OY | RN | SO | T | W | WH | WX | WW
NUMBER	[0-9]{1-6}
%%
{YEAR}-{COUNTY}-{NUMBER}[ \t\n]*	{ }
.					{ }
\n					{ }

%%
int main()
{
	yylex();
	return 0;
}
