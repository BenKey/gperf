#include <errno.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

int main()
{
    // Attempt to allocate a very large amount of memory to induce failure
    void *ptr = malloc((size_t)-1); // Or a very large number like 0xFFFFFFFFFFFFFFFFULL
    if (ptr == NULL && errno == ENOMEM)
    {
        // Success: errno is set
        return 0; 
    }
    // Clean up if allocation somehow succeeded (unlikely for -1)
    if (ptr != NULL)
    {
      free(ptr);
    }
    // Failure: errno not set as expected
    return 1; 
}
