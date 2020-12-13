# Projeto de Compilador

## Parte V: Otimização de Código

This extra credit programming assignment is intended to be a fun project with which to end the quarter. 
For this extra credit assignment, your goal is to implement some optimizations in your compiler.
Before you start this part, please pay attention to the following important notes:

Due to the constraints on getting course grades calculated, no late submissions will be accepted for this assignment.
The final curve for the course will be determined before including the extra credit. 
In other words, if you elect not to do extra credit work, 
you will __not__ be at a disadvantage in the final grading with respect to those who do.
This extra-credit option is open-ended; you can do as much as you like. 
We will award credit for results. For example, a project that merely attempts, but does not complete, an optimization phase may receive as little as no extra credit.
The total extra credit for doing optimization will not exceed 10% of the total grade for the course.
You need to include a short description of your optimizations in a README text file associated with your submission.
Under absolutely no circumstances should you try optimization before your code generator is finished!

## Otimizador de Código

The code generation technique we presented in the lecture is correct but can lead to highly suboptimal code, 
including many redundant computations, excessive loads and stores to memory/stack, inefficient use of the registers, etc.
Extra credit will be awarded for projects that, in addition to code generation, perform some significant optimization of the code. 
The amount of extra credit depends on how well the optimization is written, documented, and demonstrated. Two critical factors are

- correctness (the optimizations don’t result in incorrect programs); and
- the percentage speed-up your optimized code achieves over our reference compiler, as measured by a weighted sum of the instructions executed on spim over a suite of benchmarks of our choosing. 
Note that reads are weighted higher than regular instructions, and writes are more expensive still.

To find out how many instructions a C- program executes, run _spim_ with the _-keepstats_ option. There are many possible optimizations to implement. We have not implemented an optimization phase in our reference compiler, so we have no skeleton code to give you -— you are on your own!

A relatively simple way to significantly improve the quality of naive code is to run a peephole optimizer over the target (assembly) code. A peephole optimizer works by sliding a several-instruction window (a peephole) over the target code, looking for suboptimal patterns of instructions. You can also consider implementing 
some local optimizations by identifying the fragments of the syntax tree that correspond to basic blocks. 
For more detail, please refer to the following references:

- [Chapter 12](../../resources/chapter12-codeoptimization-DouglasThain.pdf) - Optimization from "Introduction to Compilers and Language Design" by Douglas Thain book;
- [Chapter 17](../../resources/Scott 4e_Chapter 17.pdf) - Code Improvement from "Programming Language Pragmatics" by Michael L. Scott.

---
 
- Material cedido pelo Prof. Vinicius Petrucci.
