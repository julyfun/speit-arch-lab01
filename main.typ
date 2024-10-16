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
  NCS TP2 \ \
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

= Exercise 1

See @c1, macros are modified to get the expected output.

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
