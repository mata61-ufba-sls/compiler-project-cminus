# Projeto de um Compilador

## Parte II: Análise Sintática

Nesta parte do projeto, você irá implementar um analisador sintático para a [linguagem C-](../../language/README.md), incluindo a construção da árvore sintática abstrata (AST - Abstract Syntax Tree).
O analisador sintático (_parser_) deve receber uma sequência de _tokens_ gerados pelo analisador léxico (_lexer_) e determinar se um programa C- segue ou não a especificação definida por sua gramática.
Em caso de sucesso, o _parser_ deve gerar uma AST para o programa de entrada analisado.

Antes de iniciar a sua implementação, recomendamos a leitura complementar de dois capítulos do livro "Introduction to Compilers and Language Design" de Douglas Thain. Apesar da sintaxe de C- ser um pouco diferente da usada no livro acima, os exemplos de código e o material podem ser úteis.
+ [capítulo 5](../../resources/30-chapter5-AS.pdf);
+ [capítulo 6](../../resources/31-chapter6-AST.pdf). 
  
O analisador sintático para C- deverá ser desenvolvido com Bison, com base na [especificação sintática de C-](../../language/cminus-02.md) e integrado com o analisador léxico para C- desenvolvido com Flex.
+ Material de referência: [Introducing Bison](../../resources/32-IntroducingBison.pdf).

A equipe deve usar como ponto de partida para o _lexer_, o arquivo disponibilizado pela professora: ```lexer.l```, na pasta [src/lexer](../../../src/lexer/lexer.l).

### Notação para a Árvore Sintática Abstrata (Abstract Syntax Tree - AST)

Há diversas formas para representar árvores sintáticas corretas geradas para um programa C-. 
Assim, em nosso projeto de compilador, é importante definir e usar um formato único para representar
o código na AST, que contenha um número mínimo de nós e que seja independente de qualquer implementação de linguagem específica.

Em nosso projeto de compilador, a saída do analisador sintático (_parser_) 
usará uma notação de _labelled bracketing_. 
Tal notação define listas aninhadas de _prefix expressions_ e é equivalente à representação
por meio de uma estrutura de árvore. As _prefix expressions_ correspondem aos nós da AST.

```
[operator [operand1] ... [operandN]]
```

Recursivamente, cada operando pode ser definido por outro operador; por exemplo,
```
[op1 [op2 [a] [b]] [c]]
```
onde o operador ```op1``` possui dois operandos: ```[op2 [a] [b]]``` e ```[c]```,  e o operator ```op2``` tem dois operandos: ```[a]``` e ```[b]```. 

Assim, a expressão ```4 == (2 + 2)``` em C-, 
é representada como ```[== 4 [+ 2 2]]``` na notação da AST.

### Listas de nós que podem ser mostrados na AST

A seguir, apresentamos os tipos de nós que podem aparecem em uma AST e seus nomes correspondentes, e que deverão ser produzidos pelo seu analisador sintático:  

```[program  ... ]```

* ```[var-declaration  ... ]```

   * [int]                ---> apenas int é permitido, e variáveis não podem ser do tipo void

   * [ID]                 ---> nome de variável

   * ```[\[\]]```               ---> (opcional) símbolo para descrever uma váriavel como array; IMPORTANTE: o símbolo de barra invertida (backslash \) é usado para não interpretar [ ou ] como nós de colchetes, mas para serem símbolos visíveis na AST.

* ```[fun-declaration  ... ]```

   * [int] / [void]       ---> o tipo int ou o tipo void 

   * [ID]                 ---> nome de função

   * [params  ...  ]

      * [param  ... ]        ---> (opcional) informação sobre parâmetro

         * [int] / [void]       ---> o tipo int ou o tipo void

         * [ID]                 ---> nome de varável

   * ```[compound-stmt  ... ]```     ---> (opções de filhos abaixo)

   - [;]                       ---> null statement

   - ```[selection-stmt ... ]```     ---> ou comando IF 

      * [EXPRESSION               ---> definição recursiva de qualquer expressão válida (expressão binária, variable reference, function call, etc)

      * [compound-stmt  ...]       --> ramo "then" (true) 

      * [compound-stmt  ... ]      --> (opcional) ramo "else" (false) 

   - ```[iteration-stmt  ... ]```

      * [EXPRESSION                 ---> definição recursiva de qualquer expressão válida (expressão binária, variable reference, function call, etc)

      * [compound-stmt ... ]        --> loop bloco de comandos (statements)

   - ```[return-stmt ... ]```

      * [EXPRESSION                     ---> definição recursiva de qualquer expressão válida (binary expression, variable reference, function call, etc)

    - ```[OP ... ]```                      ---> operadores de expressão binária OP = {+, -, *, /, <, <=, >, >=, ==, !=, =}                             (opções de "filhos" abaixo)

      * [var  ... ]               ---> variable reference

         * [ID]

         * [NUM]     ---> (opcional) se índice de array 

      * [NUM]               ---> constant reference

      * [call  ... ]        ----> chamada (call) de função

         * [ID]

         * [args ... ]         ----> argumentos de função

            * [var ... ]   

            * [NUM]      

            * [call ... ]   

            * [OP ... ]   

      * [OP ... ]              ---> recursivamente outra expressão binária


### Bison e Flex

O Bison deverá ser utilizado para geração do _parser_, trabalhando em conjunto com o _lexer_ gerado pelo Flex (trabalho prático 1).

```$ bison -d parser.y```

A opção -d faz com que o Bison gere dois arquivos associados a parser.y:
+ parser.tab.c
+ parser.tab.h (este arquivo faz a interface com o Flex).

O arquivo lexer.l (TP1) deverá ser alterado para incluir o arquivo "parser.tab.h". Todo o código usado para definir tokens, por exemplo, listas ou tipos escalares, deve ser eliminado. Também deve ser eliminado o código C ou C++ usado para chamar o _lexer_ e gerar o arquivo de saída solicitado no TP1.

Em seguida, rodar o flex:

```$ flex lexer.l```

e, finalmente, compilar e gerar o executável:

```$ gcc -o parser parser.tab.c lex.yy.c -ll```

### Como executar o _parser_ (usando dois argumentos: entrada e saída)
   
O programa _parser_ deve ler a entrada a partir de um arquivo (source) 
e escrever a saída em outro arquivo (target) com extensão ".ast". 
No caso de erro sintático, o conteúdo do arquivo de saída deve ser vazio (0 bytes).

```$ ./parser main.c main.ast```

### Exemplo de arquivo de entrada em C- (main.c)

```
int g;

int foo(int x, int y, int z[]) {

    z[0] = 0;
    y = x * y + 2;

    if(y == 0){
        y = 1;
    }

    return y;

}

void main(void) {

    int a[10];

    while(g < 10){
        g = foo(g, 2, a);
        ;
    }
}
```

### Exemplo de arquivo de saída após análise sintática do programa C- (main.ast)

Importante: Não é preciso se preocupar com "whitespaces" no arquivo de saída.
Eles serão ignorados na correção automática.


```
[program 
  [var-declaration [int] [g]]
  [fun-declaration 
    [int]
    [foo] 
    [params 
      [param [int] [x]] 
      [param [int] [y]] 
      [param [int] [z] [\[\]]]
    ]
    [compound-stmt 
      [= [var [z] [0]] [0]]
      [= [var [y]] 
        [+ 
          [* [var [x]] [var [y]]] [2]]]
      [selection-stmt 
        [== [var [y]] [0]]
        [compound-stmt 
          [= [var [y]] [1]]
        ]
      ]
      [return-stmt [var [y]]]
    ]
  ]
  [fun-declaration 
    [void]
    [main]
    [params]
    [compound-stmt 
      [var-declaration [int] [a] [10]]
      [iteration-stmt 
        [< [var [g]] [10]]
        [compound-stmt 
          [= [var [g]] 
            [call
              [foo]
              [args [var [g]] [2] [var [a]]]
            ]]
          [;]
        ]
      ]
    ]
  ]
]
```

![AST](../../resources/AST_rsyntaxast.png)

Esse Exemplo de ilustração de AST foi produzido a partir de https://yohasebe.com/rsyntaxtree/

--------
Adaptado e traduzido a partir do material do Prof. Vinicius Petrucci.


