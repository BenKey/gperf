#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

int main()
{
  void *ptr = malloc(0);
  if (ptr != NULL)
  {
    // malloc(0) returned non-null
    // It's good practice to free it, even if it's a zero-sized block.
    free(ptr);
    // Success: non-null returned
    return 0;
  }
  // malloc(0) returned null
  // Failure: null returned
  return 1;
}
