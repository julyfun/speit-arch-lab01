#set page(paper: "us-letter")
#set heading(numbering: "1.1.")
#set figure(numbering: "1")

#import "@preview/codelst:2.0.0": sourcecode
#show raw.where(block: true): it => {
  set text(size: 10pt)
  sourcecode(it)
}

// 这是注释
#figure(image("sjtu.png", width: 50%), numbering: none) \ \ \

#align(center, text(17pt)[
  Computer Architecture Lab01 \ \
  #table(
      columns: 2,
      stroke: none,
      rows: (2.5em),
      // align: (x, y) =>
      //   if x == 0 { right } else { left },
      align: (right, left),
      [Name:], [Junjie Fang (Florian)],
      [Student ID:], [521260910018],
      [Date:], [#datetime.today().display()],
    )
])

#pagebreak()

#set page(header: align(right)[
  DB Lab1 Report - Junjie FANG
], numbering: "1")

#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}

// [lib]
#import "@preview/tablem:0.1.0": tablem

#let three-line-table = tablem.with(
  render: (columns: auto, ..args) => {
    table(
      columns: columns,
      stroke: none,
      align: center + horizon,
      table.hline(y: 0),
      table.hline(y: 1, stroke: .5pt),
      table.hline(y: 4, stroke: .5pt),
      table.hline(y: 7, stroke: .5pt),
      ..args,
      table.hline(),
    )
  }
)

#outline(indent: 1.5em)

#set text(12pt)
#show heading.where(level: 1): it => {
  it.body
}
#set list(indent: 0.8em)

= Purpose

Learn how to use C language macros and pointers, and become familiar with the memory error detection tool valgrind and the debugger gdb.

= Answers to Questions and Steps

== Exercise 1

See @c1, macros are modified to get the expected output.

== Exercise 2

- To set arguments in GDB, use `set args <arg1> <arg2> ...`. Then `start` or `run`.
- Create breakpoint: `b <line number>`.
  - Use `i b` to list all breakpoints.
  - Use `d <breakpoint number>` to delete a breakpoint.
- Execute the next line: `n`.
- Step into the function: `s`.
- Continue the program after breakpoint: `c`.
- Print expressions: `p <expression>`. Ex: `p a + 1`.
- Display after each step: `display <expression>`. Ex: `display count`.
  - Use `undisplay <display number>` to delete a display.
- Display all variables: `i lo`.
- Quit GDB: `q`.

== Exercise 3

+ We can type and send text to stdin after GDB steps to the code `fgets(..., ..., stdin)`.
+ In GDB, type `set args < name.txt` before starting the program, this redirects stdin to the input file.

== Exercise 4

+ Why is Valgrind important and how is it useful?
  - Valgrind is a powerful tool for debugging and profiling. It can detect memory leaks, memory errors, and provide detailed information about memory usage.
+ How do you run a program in Valgrind?
  - Run `valgrind ./<program>` to check the program.
+ How do you interpret the error messages? 
  - `Conditional jump or move depends on uninitialised value(s)`
    - This indicates usage of uninitialised value
  - `Invalid write of size 4`
    - This means the program trys to write to an invalid memory location, usually caused by array out of bounds, pointer errors and dynamic memory allocation errors.
  - `by 0x48C379E: printf (printf.c:33)`
    - This shows the function where the error occurs. (possibly because the compiler optimizes the code where the value is obtained)
+ Why might uninitialized variables result in "heisenbugs"?
  - Because the value of uninitialized variables is unpredictable, the program may run correctly sometimes and fail at other times. This makes it difficult to reproduce the bug.
+ Why didn't the `no_segfault_ex` program segfault?
  - That's because the program may allocate a bit more memory (padding memory) than needed, which can prevent immediate crashes from small out-of-bounds accesses. 
+ Why does the `no_segfault_ex` produce inconsistent outputs?
  - The boundary statement `j < sizeof(a)` actually leads to an out-of-bounds access, and out-of-bound value is just random.
+ Why is `sizeof` incorrect? How could you still use `sizeof` but make the code correct?
  - The correct boundary should be `j < sizeof(a) / sizeof(a[0])`.
  - The correct output is `sum of array is 15`.

== Exercise 5

I implemented the Floyd's tortoise and hare algorithm in @c5.

= Appendix

== Exercise 1 code <c1>

```cpp
#include <stdio.h>

/* Only change any of these 4 values */
#define V0 3
#define V1 3
#define V2 1
#define V3 3

int main(void) {
    int a;
    char* s;

    /* This is a print statement. Notice the little 'f' at the end!
     * It might be worthwhile to look up how printf works for your future
     * debugging needs... */
    printf("Computer Architecture:\n====================\n");

    /* for loop */
    for (a = 0; a < V0; a++) {
        printf("Fighting ");
    }
    printf("\n");

    /* switch statement */
    switch (V1) {
        case 0:
            printf("Parallel\n");
        case 1:
            printf("SISD\n");
            break;
        case 2:
            printf("SIMD\n");
        case 3:
            printf("Parallel\n");
            break;
        case 4:
            printf("MISD\n");
            break;
        case 5:
            printf("MIMD\n");
        default:
            printf("Cache\n");
    }

    /* ternary operator */
    s = (V3 == 3) ? "Hi" : "Bye";

    /* if statement */
    if (V2) {
        printf("%s POTATO\n", s);
    } else {
        printf("%s TOMATO\n", s);
    }

    return 0;
}
```

== Valgrind output in Ex4

Run on `segfault_ex.c`:

```
==259223== Memcheck, a memory error detector                                       
==259223== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.         
==259223== Using Valgrind-3.18.1 and LibVEX; rerun with -h for copyright info      
==259223== Command: ./1                                                            
==259223==                                                                         
==259223== Invalid write of size 4                                                 
==259223==    at 0x10914F: main (in /home/julyfun/Documents/GitHub/speit-arch-lab01
/1)                                                                                
==259223==  Address 0x1fff001000 is not stack'd, malloc'd or (recently) free'd     
==259223==                                                                         
==259223==                                                                         
==259223== Process terminating with default action of signal 11 (SIGSEGV)          
==259223==  Access not within mapped region at address 0x1FFF001000                
==259223==    at 0x10914F: main (in /home/julyfun/Documents/GitHub/speit-arch-lab01
/1)                                                                                
==259223==  If you believe this happened as a result of a stack                    
==259223==  overflow in your program's main thread (unlikely but                   
==259223==  possible), you can try to increase the size of the                     
==259223==  main thread stack using the --main-stacksize= flag.                    
==259223==  The main thread stack size used in this run was 8388608.               
==259223==                                                                         
==259223== HEAP SUMMARY:                                                           
==259223==     in use at exit: 0 bytes in 0 blocks                                 
==259223==   total heap usage: 0 allocs, 0 frees, 0 bytes allocated                
==259223==                                                                         
==259223== All heap blocks were freed -- no leaks are possible                     
==259223==                                                                         
==259223== For lists of detected and suppressed errors, rerun with: -s             
==259223== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)         
Segmentation fault (core dumped)
```

Run on `no_segfault_ex.c`:

```
==259392== Memcheck, a memory error detector
==259392== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==259392== Using Valgrind-3.18.1 and LibVEX; rerun with -h for copyright info
==259392== Command: ./1
==259392==
==259392== Conditional jump or move depends on uninitialised value(s)
==259392==    at 0x48D9AD6: __vfprintf_internal (vfprintf-internal.c:1516)
==259392==    by 0x48C379E: printf (printf.c:33)
==259392==    by 0x1091E7: main (in /home/julyfun/Documents/GitHub/speit-arch-lab01/1)
==259392==
==259392== Use of uninitialised value of size 8
==259392==    at 0x48BD2EB: _itoa_word (_itoa.c:177)
==259392==    by 0x48D8ABD: __vfprintf_internal (vfprintf-internal.c:1516)
==259392==    by 0x48C379E: printf (printf.c:33)
==259392==    by 0x1091E7: main (in /home/julyfun/Documents/GitHub/speit-arch-lab01/1)
==259392==
==259392== Conditional jump or move depends on uninitialised value(s)
==259392==    at 0x48BD2FC: _itoa_word (_itoa.c:177)
==259392==    by 0x48D8ABD: __vfprintf_internal (vfprintf-internal.c:1516)
==259392==    by 0x48C379E: printf (printf.c:33)
==259392==    by 0x1091E7: main (in /home/julyfun/Documents/GitHub/speit-arch-lab01/1)
==259392==
==259392== Conditional jump or move depends on uninitialised value(s)
==259392==    at 0x48D95C3: __vfprintf_internal (vfprintf-internal.c:1516)
==259392==    by 0x48C379E: printf (printf.c:33)
==259392==    by 0x1091E7: main (in /home/julyfun/Documents/GitHub/speit-arch-lab01/1)
==259392==
==259392== Conditional jump or move depends on uninitialised value(s)
==259392==    at 0x48D8C05: __vfprintf_internal (vfprintf-internal.c:1516)
==259392==    by 0x48C379E: printf (printf.c:33)
==259392==    by 0x1091E7: main (in /home/julyfun/Documents/GitHub/speit-arch-lab01/1)
==259392==
sum of array is 104252088
==259392==
==259392== HEAP SUMMARY:
==259392==     in use at exit: 0 bytes in 0 blocks
==259392==   total heap usage: 1 allocs, 1 frees, 1,024 bytes allocated
==259392==
==259392== All heap blocks were freed -- no leaks are possible
==259392==
==259392== Use --track-origins=yes to see where uninitialised values come from
==259392== For lists of detected and suppressed errors, rerun with: -s
==259392== ERROR SUMMARY: 21 errors from 5 contexts (suppressed: 0 from 0)
```

== Ex 5 code <c5>

```c
int ll_has_cycle(node *head) {
    /* your code here */
    node* u = head;
    node* v = head;
    while (v != NULL && v->next != NULL) {
        v = v->next->next;
        u = u->next;
        if (u == v) {
            return 1;
        }
    }
    return 0;
}
```
