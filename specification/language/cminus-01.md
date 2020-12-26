# A Linguagem C-

## Aspectos Léxicos

1. Palavras-chave (_keywords_)

```
else  if  int  return  void  while
```

As palavras-chave são reservadas e devem ser escritas em letras minúsculas.

2. Símbolos especiais

```
  +  -  *  /  <  <=  >  >=  ==  !=  =  ;  ,  (  )  [  ]  {  } 
```

 3. ID (identificadores) e NUM (números inteiros)

```
  ID = letter (letter | digit)*

  NUM = digit digit*

  letter = a | .. | z | A | .. | Z

  digit = 0 | .. | 9
```

Caracteres minúsculos e maiúsculos são diferenciados.

4. Caracteres de espacejamento (_white space_) incluem _blanks_ (' '), _newlines_ ('\n'), e _tabs_ ('\t'). Tais caracteres devem ser ignorados exceto quando separam  ID, NUM e palavras-chave.

5. Comentários de uma linha apenas

Comentários de uma linha (_single-line comments_) sempre são iniciados por "//".
Comentários não podem se estender por mais de uma linha e não podem ser aninhados.
Outros tipos de comentários não são suportados.

6. Erros Léxicos para C-

Apenas um erro léxico em programas C- deve ser reportado:
+ Caracter desconhecido, por exemplo, "&".

A análise léxica de programas C- __não__ deve dar suporte a:
- tratamento de erros, por exemplo, "0a" não será tratado como erro léxico; o analisador léxico deverá retornar "NUM" 0 e "ID" a.
- funcionalidades que não estão na especificação da linguagem, por exemplo, comentários de várias linhas.


-----
Adaptação com base no material cedido pelo Prof. Vinicius.
