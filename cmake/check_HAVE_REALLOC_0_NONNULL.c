#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

int main()
{
    /* Allocate a small block. */
    void *ptr = malloc(1);
    if (ptr == NULL)
    {
        /* Malloc failed, can't test realloc. */
        fprintf(stderr, "malloc failed.\n");
        return 1;
    }
    /* If we got this far the program should return 0 to indicate that the test
    was successful. The displayed output will indicate whether `realloc`
    returned non-null. */
    void *new_ptr = realloc(ptr, 0);
    if (new_ptr != NULL)
    {
        free(new_ptr);
        fprintf(stdout, "REALLOC_0_NONNULL\n");
    }
    else
    {
        /* Do not free ptr. On some systems that causes a crash! */
        fprintf(stdout, "REALLOC_0_NULL\n");
    }
    /* Return 0 to indicate success. */
    return 0;
}
