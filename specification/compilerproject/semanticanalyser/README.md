# Projeto de um Compilador

## Parte III: Análise Semântica

Nesta parte do projeto, você irá implementar um analisador semântico para a [linguagem C-](../../language/README.md).
Na etapa de análise semântica, a árvore sintática abstrata AST criada pelo analisador sintático será visitada para realização de alguns tipos de análise para determinar a corretude semântica de programas em C-.
Referências para símbolos (nomes de variáveis e de funções) declarados devem ser definidas, os tipos de expressões devem ser inferidos, e a compatibilidade entre valores deve ser verificada. 
Será necessário fazer a verificação com base nas regras de escopo e de tipo especificadas pela semântica da linguagem.  Consulte a especificação do projeto de linguagem e semântica associada à linguagem C-.  

Recomendo fortemente que leia com atenção o conteúdo do Capítulo 7 – Semantic Analysis do livro "Introduction to Compilers and Language Design" de Douglas Thain.

+ [capítulo 7](../../resources/40-chapter7-Semantics.pdf);

The AST is used during semantic analysis by the compiler to check for correct usage of the elements of the language. The compiler also produces a symbol table based on the AST during semantic analysis. A complete traversal of the AST allows verification of the correctness of the program given the language specification. After verifying correctness, the AST serves as the base for code generation.

In particular, in addition to the AST data structure, you will be using the symbol table for checking scope and language types.  Remember if your compiler finds any semantic error, it should stop and the output file should be empty. That means, the AST will not be written to the output file. Below we provide you with a non-exhaustive check list you should be looking into.

## Check List for Semantic Analysis (non exhaustive):

```<program> ::= <declaration-list>
<declaration-list> ::= <declaration-list> <declaration> | <declaration>
<declaration> ::= <var-declaration> | <fun-declaration>
```  

- [   ]  All variables and functions must be declared before they are used

- [   ]  The last declaration in a program needs to be a declaration of the form void main (void)


``` 
<var-declaration> ::= <type-specifier> ID ; | <type-specifier> ID [ NUM ] ;
<type-specifier> ::= int | void
```

- [   ]  Variable declarations can only have int type.


``` 
<fun-declaration> ::= <type-specifier> ID ( <params> ) <compound-stmt>
<params> ::= <param-list> | void
<param-list> ::= <param-list> , <param> | <param>
<param> ::= <type-specifier> ID | <type-specifier> ID [ ] 
```

- [   ]  Parameter types for variable names cannot be void (except main function)

- [   ]  Parameters followed by brackets are vector parameters to which the size is variable

- [   ]  Parameters for arrays must match array-type variable during function call

- [   ]  Parameters for integer variables cannot be used as array references (array accesses/subscripts are valid, though)

- [   ]  Non-array parameters should not match arrays (array accesses/subscripts are valid, however)

- [   ]  Functions can be recursive (to the limit that declarations before-use allow)

```
<compound-stmt> ::= { <local-declarations> <statement-list> }
``` 

- [   ]  Variable declaration has the same scope as the set of statements in braces and overrides the visibility of global variables.


``` 
<return-stmt> ::= return ; | return <expression> ;
``` 

- [   ]  Functions not declared as void must return values.

- [   ]  Functions declared as void must not return values.


``` 
<expression> ::= <var> = <expression> | <simple-expression>
<var> ::= ID | ID [ <expression> ]
``` 

- [   ]  Variable must be declared.

- [   ]  Use of an array name anywhere is invalid except in arguments of function calls

- [   ]  An expression to be assigned to a variable must refer to data value that is stored at some address in memory.  

- [   ]  Check correct assignments from return statements of void vs int functions

- [   ]  Type checking of the expressions vs variable types


```
<factor> ::= ( <expression> ) | <var> | <call> | NUM
``` 

- [   ]  Check correct usage of function return

- [   ]  Array variables must be indexed, except in expressions containing a single ID (function calls)


```
<call> ::= ID ( <args> )
<args> ::= <arg-list> | empty
<arg-list> ::= <arg-list> , <expression> | <expression>
``` 


- [  ]  Functions need to be declared before being called

- [  ]  The number of arguments in a function call must be equal to the number of parameters in the declaration


```
int input(void)  {...}
void output(int x) {...}
```

- [  ]  Make sure to include these names (builtin functions)

- [  ]  Check return type, input, number of params.



### Other general checks
 
- [  ]  Using a function name in a variable name context (and vice-versa) should be disallowed.

- [  ]  Function redeclared as function

- [  ]  Function redeclared as variable

- [  ]  Function redeclared as parameter

- [  ]  Function redeclared as local variable (allowed)

- [  ]  Variable redeclared as variable

- [  ]  Variable redeclared as function

- [  ]  Variable redeclared as parameter

- [  ]  Variable redeclared as local variable

- [  ]  Parameter redeclared as parameter

- [  ]  Parameter redeclared as local variable

- [  ]  Parameter redeclared as local variable on inner scope (allowed)

- [  ]  Local variable redeclared as local variable on same scope

- [  ]  Local variable redeclared as local variable on inner scope (allowed)

- [  ]  There are no declarations

- [  ]  There is no main.

- [  ]  The last declaration is not a function.

- [  ]  The last declaration name is not "main".

[  ]  The last declaration does not return void.

[  ]  The last declaration has more than zero params.


### Reference compiler (syntactic/semantic phase)

Sample binary (Linux ELF 64-bit LSB executable, x86-64.

If you're using Windows, you can install and use the Linux Ubuntu terminal! See this tutorial

Input samples here.

