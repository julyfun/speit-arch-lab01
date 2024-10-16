#include <stddef.h>
#include "ll_cycle.h"

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
