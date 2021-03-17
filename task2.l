%{
/* Ryan Kabrick          */
/* CPEG621: Compilers    */
/* Project 1: Prefix Calc */
#include <stdlib.h> /* For atoi call */
#include <string.h>
#include "prefix.tab.h"

extern int LineNum;
void yyerror(char *);
%}

/* Suppress 'unused' warnings */
%option noinput
%option nounput 

%% 

[a-z][A-Za-z0-9]* {
	#ifdef DEBUG
	printf("token %s in line %d\n", yytext, LineNum);
	#endif
	yylval.VarName = strdup(yytext);
	return VAR;
	}

[0-9]+ {
	#ifdef DEBUG
	printf("token %s in line %d\n", yytext, LineNum);
	#endif
	yylval.Value = atoi(yytext);
	return INT;
	}

"**" {
	#ifdef DEBUG
	printf("token %s in line %d\n", yytext, LineNum);
	#endif
	return POW;
	}

[-+()=*/!] { /* all single symbol operators ( no '**' ) */
		#ifdef DEBUG
		printf("token %s in line %d\n", yytext, LineNum);
		#endif
		return *yytext;
	}


"\n" { /* need be able to initiate evaluation of input */ 
	#ifdef DEBUG
	printf("token \\n in line %d\n", LineNum);
	#endif
	LineNum++;
	return *yytext;
	}


[ \t]+ { /* ignore whitespace (per the manual) */ 
	#ifdef DEBUG
	printf("token is whitespace(s) in line %d\n", LineNum);
	#endif
	}

. { yyerror("Invalid syntax"); }

%%
/* avoid linking problem */
int yywrap() {
	return 1;
}

