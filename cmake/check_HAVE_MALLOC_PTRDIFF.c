#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

int main()
{
    size_t requested_size = (size_t)PTRDIFF_MAX + 1; // Or some other large value
    void* ptr = malloc(requested_size);
    if (ptr != NULL)
    {
        printf("ALLOCATION_SUCCESS\n");
        free(ptr);
    }
    else
    {
        printf("ALLOCATION_FAILURE\n");
    }
    return 0;
}
