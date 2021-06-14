
%{
	#include <malloc.h>
	#include <stdlib.h>
	#include <stdio.h>
	#include <math.h>
	int   VAL[26];
	int cntt =0;
%}

%token NEWLINE PLUS MINUS MULTIPLICATION DIVISION CM SM IDENTIFIER NUMBER NUMB STRING SWITCH CASE BREAK DEFAULT GCD LCM PRIME
%token LP RP IF GT LT LB RB IDENTIFIER1 EQUAL ELSE MOD DOUBLE SIN COS TAN LOG WHILE FOR COL FACTORIAL ODDEVEN 
%left PLUS MINUS
%left MULTIPLICATION DIVISION
%left TO
%left  LT GT
%right EQUAL
%right MOD
%left SIN COS TAN LOG

/* --------------------------grammar rules-------------------------------- */

%%

START: /* empty */

	| START  stmt 
	;
	
stmt:NEWLINE

	| exp NEWLINE 		{ if($1>floor($1) && $1<ceil($1))  printf("%lf\n",$1); else if($1==-1); else printf("%d\n",$1); }
	
	| type var SM 		{printf("Valid identifier\n");}

	| IDENTIFIER1 EQUAL exp SM    { VAL[$1] = $3; }

	| FOR LP NUMB SM NUMB RP LB exp RB {
	                                int i;
	                                for(i=$3 ; i<$5 ; i++) 
									{printf("value of the for loop: %d expression value: %d\n", i,$8);}	
									printf("\n");
	}
	
	| WHILE LP NUMB GT NUMB RP LB exp RB   {
										int i;
										for(i=$5; i<=$3; i++)
										{printf("value of the while loop: %d expression value: %d\n", i,$8);}
										printf("\n");
	}
	
	| SWITCH LP NUMB RP LB SWITCHCASE RB 
	
	| IF LP exp RP	exp SM	{
									if($3)
									{
										printf("\nvalue of expression in IF: %d\n",$5);
									}
									
	}

	| IFELSE

	| IF LP exp RP    IF LP exp RP exp SM ELSE exp SM    SM ELSE exp SM {
								 	if($3)
									{

										if($7)
										{
											printf("value of expression in Nested  IF: %d\n",$9);
										}
										else
										{
											printf("value of expression in Nested else: %d\n",$12);
										}
									}
									else
									{
										printf("value of expression in Outer ELSE: %d\n",$16);
									}
	}
	
	| FACTORIAL LP NUMB RP SM {
		int i;
		int f=1;
		for(i=1;i<=$3;i++)
		{
			f=f*i;
		}
		printf("FACTORIAL of %d is : %d\n",$3,f);

		}

	| ODDEVEN LP NUMB RP SM {

		if($3 %2 ==0){
			printf("Number : %d is Even\n",$3);
		}
		else{
			printf("Number is :%d is Odd\n",$3);
		}
		
		}
	|GCD LP NUMB CM NUMB RP SM  { int n1=$3,n2=$5,g;
	                                            for(int i=1; i<=n1&&i<=n2; i++)
												{
												  if(n1%i==0&&n2%i==0)
												  {
												     g=i;
												
												 }
												 }
											printf("Gcd of %d and %d = %d\n",$3,$5,g);
										}
    |LCM LP NUMB CM NUMB RP SM { int n1=$3,n2=$5,g;
	                                            for(int i=1;i<=n1&&i<=n2;i++)
												{
												  if(n1%i==0&&n2%i==0)
												  {
												     g=i;
												
												 }
												 }
												 int x=n1/g*n2;
											printf("Lcm of %d and %d = %d\n",$3,$5,x);
	
	                                    }
	|PRIME LP NUMB RP SM { int c=1; for(int i=2;i*i<=$3;i++){ if($3 % i==0){ printf("\n%d is not prime\n",$3); c=0; break;}}
	                                    if(c){ printf("\n%d is prime\n",$3);}}
	;
	
SWITCHCASE: casegrammer
		|casegrammer defaultgrammer
		;

casegrammer: /*empty*/
		| casegrammer casenumber
		;

casenumber: CASE NUMB COL exp SM {printf("\nCase No : %d & expression value :%d \n",$2,$4);}
		;
defaultgrammer: DEFAULT COL exp SM {
			printf("Default case & expression value : %d\n",$3);
		}
	;
IFELSE: IF LP exp RP exp SM ELSE exp SM {
								 	if($3)
									{
										printf("value of expression in IF: %d\n",$5);
									}
									else
									{
										printf("value of expression in ELSE: %d\n",$8);
									}
		}
		;
		
				 
var: var CM IDENTIFIER
	|IDENTIFIER                   
	;
	
type:NUMBER
	|STRING
	;

exp:     NUMB						{ $$ = $1; 	}
		|DOUBLE						{ $$ = $1; 	}
		
		| IDENTIFIER1				{$$ = VAL[$1];}

        | exp PLUS exp				{ $$ = $1 + $3; }

        | exp MINUS exp 			{ $$ = $1 - $3; }

        | exp MULTIPLICATION exp	{ $$ = $1 * $3; }

        | exp DIVISION exp			{ if($3!=0) $$ = $1 / $3; else{ printf("Divide by zero error");$$=-1;$1=-1;}}

        | exp GT exp				{ $$ = $1 > $3; }

        | exp LT exp				{ $$ = $1 < $3; }

        | exp MOD exp 				{ $$ = $1 % $3;}

        | SIN exp 					{printf("Value of Sin(%d) is %lf\n",$2,sin($2*3.1416/180)); $$=-1;}

        | COS exp 					{printf("Value of Cos(%d) is %lf\n",$2,cos($2*3.1416/180)); $$=-1;}

        | TAN exp 					{printf("Value of Tan(%d) is %lf\n",$2,tan($2*3.1416/180)); $$=-1;}

        | LOG exp 					{printf("Value of Log(%d) is %lf\n",$2,log($2)/2.303); $$=-1;}




	;

%%


