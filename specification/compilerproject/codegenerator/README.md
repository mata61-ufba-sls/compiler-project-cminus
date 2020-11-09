#Part IV: Code Generation

In this part of the project you will implement the code generation stage of your compiler, producing MIPS assembly code as a result. This is the most exciting part that will finally emit working assembly code. The code generation will be performed using the AST and symbol table produced during the syntactic and semantic analysis. Here we are mostly interested in the compiler correctness, and not concerned about the efficiency of the resulting assembly code. An important advice is to start with some extremely simple programs (e.g. "void main(void) { return 2+3; }") and gradually add complexity bit by bit. 

A practical reference for this part of the project can be found on Chapter 11 – Code Generation from the book "Introduction to Compilers and Language Design" by Douglas Thain. While the examples in the chapter is given in X86-64 assembly, it should not be hard to adapt to the MIPS assembly (our target language).

## MIPS Simulator
To evaluate your compiler that produces code for the target language (MIPS assembly) we will use the SPIM simulator (details in the manual here). The SPIM (MIPS32 simulator) can be downloaded here. If you use Ubuntu Linux, you can simply install SPIM with the command "sudo apt-get install spim". Refer to this discussion if you have questions about how to allocate memory in MIPS for variables (global and local) and dynamically (Heap) arrays.

## Input/output
Your compiler implementation must support the following input and output functions:

- ```int input(void) {...}``` - takes no parameters and returns an integer value from the standard input device
  
- ```void output(int x) {...}``` - displays the integer value passed as parameter in the standard output, followed by a line break (\n).

These functions are not defined in the language grammar, but rather as part of the runtime environment. To implement them, you must use specific system calls ("print_int" and "read_int") available in SPIM (see details here).

## Reference compiler (code generation)

- Sample binary (Linux ELF 64-bit LSB executable, x86-64) here

   - If you're using Windows, you can install and use the Linux Ubuntu terminal! See this tutorial

- Input files here

## Example

- Simple input file

void main(void) { output(4+5); }

- Run your compiler while receiving two arguments (input file and output file)

$ ./codegen ex.c ex.s

- Example of output file (ex.s) in MIPS assembly:

```
.data

.text


_f_output:

  lw $a0, 4($sp)

  li $v0, 1

  syscall

  li $v0, 11

  li $a0, 0x0a

  syscall

  addiu $sp, $sp, 4

  li $a0, 0

  j $ra



_f_main:

  sw $ra, 0($sp)

  addiu $sp, $sp, -4

  li $a0, 4

  sw $a0, 0($sp)

  addiu $sp, $sp, -4

  li $a0, 5

  lw $t1, 4($sp)

  addiu $sp, $sp, 4

  add $a0, $t1, $a0

  sw $a0, 0($sp)

  addiu $sp, $sp, -4

  jal _f_output

  lw $ra, 4($sp)

  addiu $sp, $sp, 4

  j $ra



main:

  jal _f_main

  li $v0, 10

  syscall
```

- Executing MIPS output code using the SPIM simulator

It is important to know that the output of the SPIM simulator will be considered, in which the instructions of the assembly code produced will be executed to evaluate the correctness of the your compiler implementation.

```  
$ spim -file ex.as

SPIM Version 8.0 of January 8, 2010

Copyright 1990-2010, James R. Larus.

All Rights Reserved.

See the file README for a full copyright notice.

Loaded: /usr/lib/spim/exceptions.s

9
```
