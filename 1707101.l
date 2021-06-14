
%{
	#include "1707101.tab.h"
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include <math.h>
	int cheader = 0, ckeyword = 0, coperator = 0, cpunctuation = 0, cidentifier = 0, ccomment = 0, clibraryf = 0;
%}


header                 	INC[ ]+[<][^\n]+[.H][>]
keyword                	NUM|String|IF|Else|FOR|WHILE|SWITCH|CASE|BREAK|DEFAULT
operator				pls|mns|mul|div|gt|lt|mod|eq|sin|cos|log|tan
punctuation				lb|rb|lp|rp|cm|sm|col
identifier				[a-zA-Z_]+[0-9]*
num	    				[+-]?[0-9]+
DOUBLE					[0-9]*[.]?[0-9]*
single_line_comment 	[/][/].*


%%
{header}               	{cheader++;}
{keyword}              	{ckeyword++;
							if(strcmp(yytext,"NUM")==0)  			return NUMBER;
						 	else if(strcmp(yytext,"String")==0)  	return STRING;
						 	else if(strcmp(yytext,"IF")==0)  		return IF;
						 	else if(strcmp(yytext,"Else")==0)  		return ELSE;
						 	else if(strcmp(yytext,"FOR")==0) 		return FOR;
							else if(strcmp(yytext,"WHILE")==0) 		return WHILE;
							else if(strcmp(yytext,"SWITCH")==0) 	return SWITCH;
							else if(strcmp(yytext,"CASE")==0) 		return CASE;
							else if(strcmp(yytext,"BREAK")==0) 		return BREAK;
							else if(strcmp(yytext,"DEFAULT")==0) 	return DEFAULT;
							
						 }
{operator}              {coperator++;
							if(strcmp(yytext,"pls")==0)  			return PLUS;
						 	else if(strcmp(yytext,"mns")==0)  		return MINUS;
						 	else if(strcmp(yytext,"div")==0)  		return DIVISION;
						 	else if(strcmp(yytext,"mul")==0)  		return MULTIPLICATION;
						 	else if(strcmp(yytext,"gt")==0)  		return GT;
						 	else if(strcmp(yytext,"lt")==0)  		return LT;
						 	else if(strcmp(yytext,"eq")==0)  		return EQUAL;
						 	else if(strcmp(yytext,"mod")==0)  		return MOD;
						 	else if(strcmp(yytext,"sin")==0)  		return SIN;
						 	else if(strcmp(yytext,"cos")==0)  		return COS;
						 	else if(strcmp(yytext,"tan")==0)  		return TAN;
						 	else if(strcmp(yytext,"log")==0)  		return LOG;
						}
{punctuation}			{cpunctuation++;
							if(strcmp(yytext,"cm")==0)  			return CM;
						 	else if(strcmp(yytext,"sm")==0)  		return SM;
							else if(strcmp(yytext,"col")==0)  		return COL;
						 	else if(strcmp(yytext,"lp")==0)  		return LP;
						 	else if(strcmp(yytext,"rp")==0)  		return RP;
						 	else if(strcmp(yytext,"lb")==0)  		return LB;
						 	else if(strcmp(yytext,"rb")==0)  		return RB;
						}
"\n"					{return NEWLINE;}

{num}					{
							sscanf(yytext, "%d", &yylval);
							return NUMB;
						}
{DOUBLE}				{
							sscanf(yytext, "%lf", &yylval);
							return DOUBLE;
						}
[a-z]    			    {
                			yylval = *yytext - 'a';
                			return IDENTIFIER1;
            			}
"FACTORIAL"		        {clibraryf++; return FACTORIAL;}
"ODDEVEN"		        {clibraryf++; return ODDEVEN;}
"GCD"		       	    {clibraryf++; return GCD;}
"LCM"		            {clibraryf++; return LCM;}
"PRIME"		            {clibraryf++; return PRIME;}
{identifier}			{cidentifier++; return IDENTIFIER;}
{single_line_comment} 	{ccomment++;}	
  
.                      	

%%

int yywrap()
{
	return 1;
}
int yyerror(char *s)
{
	printf("%s\n",s);
	return(0);
}


int main(void)
{
	freopen("my_input.txt","r",stdin);
	freopen("out.txt","w",stdout);
	yyparse();
	printf("\nHeaders=%d\nComments=%d\nIdentifiers=%d\nOperators=%d\nPunctuations=%d\nKeywords=%d\nBuiltIn_Function=%d\n",
				cheader, ccomment, cidentifier, coperator, cpunctuation, ckeyword, clibraryf);
	exit(0);
}


