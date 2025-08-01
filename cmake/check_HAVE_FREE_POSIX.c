#include <errno.h>
#include <stdio.h>
#include <stdlib.h>

int main()
{
    /* Set errno to a non-zero value. */
    errno = EINVAL;
    /* Allocate a small amount of memory. */
    void *ptr = malloc(1); 
    if (ptr == NULL)
    {
        /* Indicate malloc failure. */
        return 2; 
    }
    /* Call free. */
    free(ptr); 
    if (errno == EINVAL)
    {
        fprintf(stdout, "ERRNO_PRESERVED\n");
    }
    else
    {
        fprintf(stdout, "ERRNO_NOT_PRESERVED\n");
    }
    return 0;
}
