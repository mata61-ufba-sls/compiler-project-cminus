%{
#include "parser.tab.h"
%}

%%
[0-9]+          { return NUM; }
("if"|"else"|"int"|"return"|"while")    { return KEY; }
[A-Za-z][A-Za-z0-9]*                    { return ID; }
"//"[^/\n]+"\n" { }
"!="            { return SYM; }
"="             { return SYM; }
"=="            { return SYM; }
"<="            { return SYM; }
">="            { return SYM; }
"<"             { return SYM; }
">"             { return SYM; }
","             { return SYM; }
";"             { return SYM; }
"("             { return SYM; }
")"             { return SYM; }
"{"             { return SYM; }
"}"             { return SYM; }
"+"             { return SYM; }
"-"             { return SYM; }
"*"             { return SYM; }
"/"             { return SYM; }
[ \t\n]         { }
.               { return ERROR; }
%%
