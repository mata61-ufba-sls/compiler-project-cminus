# A Linguagem C-

## Aspectos Semânticos

Para cada regra gramatical, será apresentada uma breve descrição da semântica associada.

```<program> ::= <declaration-list>

<declaration-list> ::= <declaration-list> <declaration> | <declaration>

<declaration> ::= <var-declaration> | <fun-declaration>
```  

A program consists of a list (or sequence) of declarations, which may be function or variable declarations, in any order. There must be at least one declaration. Semantic restrictions are as follows (these do not occur in C). All variables and functions must be declared before they are used (this avoids backpatching references): The last declaration in a program must be a function declaration of the form void main (void). Note that C- lacks prototypes, so that no distinction is made between declarations and definitions (as in C).


``` 
<var-declaration> ::= <type-specifier> ID ; | <type-specifier> ID [ NUM ] ;

<type-specifier> ::= int | void
```
  
A variable declaration declares either a simple variable of integer type or an array variable whose base type is integer, and whose indices range from 0  . . NUM-1. Note that in C- the only basic types are integer and void. In a variable declaration, only the type specifier int can be used. Void is for function declarations (see below). Note, also, that only one variable can be declared per declaration.

``` 
<fun-declaration> ::= <type-specifier> ID ( <params> ) <compound-stmt>

<params> ::= <param-list> | void

<param-list> ::= <param-list> , <param> | <param>

<param> ::= <type-specifier> ID | <type-specifier> ID [ ] 
```
  
A function declaration consists of a return type specifier, an identifier, and a comma-separated list of parameters inside parentheses, followed by a compound statement with the code for the function. If the return type of the function is void, then the function returns no value (i.e., is a procedure). Parameters of a function are either void (i.e., there are no parameters) or a list representing the function's parameters. Parameters followed by brackets are array parameters whose size can vary. Simple integer parameters are passed by value. Array parameters are passed by reference (i.e., as pointers) and must be matched by an array variable during a call. Note that there are no parameters of type "function." The parameters of a function have scope equal to the compound statement of the function declaration, and each invocation of a function has a separate set of parameters. Functions may be recursive (to the extent that declaration before use allows).

```
<compound-stmt> ::= { <local-declarations> <statement-list> }
``` 
A compound statement is executed by executing the statement sequence in the order given. The local declarations have scope equal to the statement list of the compound statement and supersede any global declarations. 

```
<local-declarations> ::= <local-declarations> <var-declaration> | /* empty */

<statement-list> ::= <statement-list> <statement> | /* empty */
```
Note that both declarations and statement lists may be empty. (The non-terminal empty stands for the empty string (epsilon), sometimes written as ε).

```
<statement> ::= <expression-stmt> | <compound-stmt> | <selection-stmt> 
              | <iteration-stmt> | <return-stmt>

<expression-stmt> ::= <expression> ; | ;
``` 
An expression statement has an optional expression followed by a semicolon. Such expressions are usually evaluated for their side effects. Thus, this statement is used for assignments and function calls.

```
<selection-stmt> ::= if ( <expression> ) <statement> 
                  | if ( <expression> ) <statement> else <statement>
```

The if-statement has the usual semantics: the expression is evaluated; a nonzero value causes execution of the first statement; a zero value causes execution of the second statement, if it exists. This rule results in the classical dangling else ambiguity, which is resolved in the standard way: the else part is always parsed immediately as a substructure of the current if-statement (the "most closely nested" disambiguating rule).

```
<iteration-stmt> ::= while ( <expression> ) <statement>
```

The while-statement is the only iteration statement in C-. It is executed by repeatedly evaluating the expression and then executing the statement if the expression evaluates to a nonzero value, ending when the expression evaluates to 0.

```
<return-stmt> ::= return ; | return <expression> ;
```
A return statement may either return a value or not. Functions not declared void must return values. Functions declared void must not return values. A return causes transfer of control back to the caller (or termination of the program if it is inside main).

```
<expression> ::= <var> = <expression> | <simple-expression>

<var> ::= ID | ID [ <expression> ]
```

An expression is a variable reference followed by an assignment symbol (equal sign) and an expression, or just a simple expression. The assignment has the usual storage semantics: the location of the variable represented by var is found, then the sub-expression to the right of the assignment is evaluated, and the value of the sub-expression is stored at the given location. This value is also returned as the value of the entire expression. A var is either a simple (integer) variable or a sub-scripted array variable. A negative subscript causes the program to halt (unlike C).  However, upper bounds of subscripts are not checked.
Variables represent a further restriction of C- from C. In C the target of an assignment must be an l-value, and l-values are addresses that can be obtained by many operations. In C- the only I-values are those given by the var syntax, and so this category is checked syntactically, instead of during type checking as in C. Thus, pointer arithmetic is forbidden in C-. 

```
<simple-expression> ::= <additive-expression> <relop> <additive-expression> 
                      | <additive-expression>

<relop> ::= <= | < | > | >= | == | !=
```

A simple expression consists of relational operators that do not associate (that is an unparenthesized expression can only have one relational operator). The value of a simple expression is either the value of its additive expression if it contains no relational operators, or 1 if the relational operator evaluates to true, or 0 if it evaluates to false.

```
<additive-expression> ::= <additive-expression> <addop> <term> | <term>

<addop ::= + | -

<term> ::= <term> <mulop> <factor> | <factor>

<mulop> ::= * | /
```

Additive expressions and terms represent the typical associativity and precedence of the arithmetic operators, The / symbol represents integer division; that is, any remainder is truncated.

```
<factor> ::= ( <expression> ) | <var> | <call> | NUM
```

A factor is an expression enclosed in parentheses, a variable, which evaluates to the value of its variable; a call of a function, which evaluates to the returned value of the function; or a NUM, whose value is computed by the scanner. An array variable must be subscripted, except in the case of an expression consisting of a single ID and used in a function call with an array parameter (see below).

```
<call> ::= ID ( <args> )

<args> ::= <arg-list> | /* empty */

<arg-list> ::= <arg-list> , <expression> | <expression>
```

A function call consists of an ID (the name of the function), followed by parentheses enclosing its arguments. Arguments are either empty or consist of a comma-separated list of expressions, representing the values to be assigned to parameters during a call. Functions must be declared before they are called, and the number of parameters in a declaration must equal the number of arguments in a call. An array parameter in a function declaration must be matched with an expression consisting of a single identifier representing an array variable.

Finally, the above rules give no input or output statement. We must include such functions in the definition of C-, since unlike C, C- has no separate compilation or linking facilities. We, therefore, consider two functions to be predefined in the global environment, as though they had the indicated declarations:

```
int input(void)  {...}

void output(int x) {...}
```

The input function has no parameters and returns an integer value from the standard input device (usually the keyboard). The output function takes one integer parameter, whose value it prints to the standard output (usually the screen), together with a newline.

-----
Adaptação com base no material cedido pelo Prof. Vinicius Petrucci.


