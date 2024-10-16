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
