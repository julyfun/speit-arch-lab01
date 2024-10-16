#include <stdio.h>

void func() {
    int l = 1;
    int c = l + 2;
}

int main(int argc, char *argv[]) {
    int i;
    int count = 0;
    int *p = &count;

    func();

    for (i = 0; i < 10; i++) {
        (*p)++; // Do you understand this line of code and all the other permutations of the operators? ;)
    }

    printf("Thanks for waddling through this program. Have a nice day.");
    return 0;
}
