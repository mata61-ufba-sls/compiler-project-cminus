# A Linguagem C-

## Convenções Léxicas

1. Palavras-chave (_keywords_)

```
else  if  int  return  void  while
```

As palavras-chave são reservadas e devem ser escritam em letras minúsculas.

2. Símbolos especiais

```
  +  -  *  /  <  <=  >  >=  ==  !=  =  ;  ,  (  )  [  ]  {  }  //
```

 3. ID (identificadores) e NUM (números inteiros)

```
  ID = letter (letter | digit)*

  NUM = digit digit*

  letter = a | .. | z | A | .. | Z

  digit = 0 | .. | 9
```

Carateres minúsculos e maiúsculos são diferenciados.

4. Caracteres de espacejamento (_white space_) incluem _blanks_ (' '), _newlines_ ('\n'), e _tabs_ ('\t'). Tais caracteres devem ser ignorados exceto quando separam  ID, NUM e palavras-chave.

5. Comentários de uma linha apenas

Comentários de uma linha (_single-line comments_) sempre são iniciados por "//".
Comentários não podem se estender por mais de uma linha e não podem ser aninhados.
Outros tipos de comentários  não são suportados.

## Sintaxe

### BNF para C-

```
<program> ::= <declaration-list>

<declaration-list> ::= <declaration-list> <declaration> | <declaration>

<declaration> ::= <var-declaration> | <fun-declaration>

<var-declaration> ::= <type-specifier> ID ; | <type-specifier> ID [ NUM ] ;

<type-specifier> ::= int | void

```

```
<fun-declaration> ::= <type-specifier> ID ( <params> ) <compound-stmt>

<params> ::= <param-list> | void

<param-list> ::= <param-list> , <param> | <param>

<param> ::= <type-specifier> ID | <type-specifier> ID [ ] 

```

```
<compound-stmt> ::= { <local-declarations> <statement-list> }

<local-declarations> ::= <local-declarations> <var-declaration> | empty

<statement-list> ::= <statement-list> <statement> | empty

<statement> ::= <expression-stmt> | <compound-stmt> | <selection-stmt> 

              | <iteration-stmt> | <return-stmt>

<expression-stmt> ::= <expression> ; | ;

<selection-stmt> ::= if ( <expression> ) <statement> 

                  | if ( <expression> ) <statement> else <statement>

<iteration-stmt> ::= while ( <expression> ) <statement>

<return-stmt> ::= return ; | return <expression> ;

```

```
<expression> ::= <var> = <expression> | <simple-expression>

<var> ::= ID | ID [ <expression> ]

<simple-expression> ::= <additive-expression> <relop> <additive-expression> 

                       | <additive-expression>

<relop> ::= <= | < | > | >= | == | !=

<additive-expression> ::= <additive-expression> <addop> <term> | <term>

<addop ::= + | -

<term> ::= <term> <mulop> <factor> | <factor>

<mulop> ::= * | /

<factor> ::= ( <expression> ) | <var> | <call> | NUM

<call> ::= ID ( <args> )

<args> ::= <arg-list> | empty

<arg-list> ::= <arg-list> , <expression> | <expression>

```

-----
Adaptação com base no material cedido pelo Prof. Vinicius.
