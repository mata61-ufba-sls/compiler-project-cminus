# compile.sh

bison -d parser.y
flex ../lexer/lexer.l
gcc -o parser parser.tab.c lex.yy.c -ll
