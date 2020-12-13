%{
#include "parser.tab.h"
%}

%%
"//".*  { /* ignore comment  */ }

[0-9]+          { return NUM; }

("else"|"if"|"int"|"return"|"void"|"while")  { return KEY; }

[A-Za-z][A-Za-z0-9]* { return ID; }

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
"["             { return SYM; }
"]"             { return SYM; }
"+"             { return SYM; }
"-"             { return SYM; }
"*"             { return SYM; }
"/"             { return SYM; }

[ \t]   { /* ignore white space */ }
[\n]    { /* ignore white space and count lines, if you want */ }

.               { return ERROR; }
%%
