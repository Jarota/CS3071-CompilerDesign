%{

%}

NEWYEAR		[0-9]{2}[12]
OLDYEAR		[0-9]{2}
NEWCOUNTY	C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|T|W|WH|WX|WW
OLDCOUNTY	C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LK|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|TN|TS|W|WD|WH|WX|WW
NUMBER	[0-9]{1-6}
%%
{NEWYEAR}-{NEWCOUNTY}-{NUMBER}	{
	char ystr[2];
	strncpy(ystr, yytext, 2);
	int y = atoi(ystr);
	printf("%d\n", 18-y);
}
{OLDYEAR}-{OLDCOUNTY}-{NUMBER}	{
	char ystr[2];
	strncpy(ystr, yytext, 2);
	int y = atoi(ystr);
	y+=1900;
	printf("%d\n", 2018-y);
}
.*[ \t\n]				{ printf("INVALID\n"); }

%%
int main()
{
	yylex();
	return 0;
}
