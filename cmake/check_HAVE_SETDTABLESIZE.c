#include <sys/resource.h>

int main()
{
    /* Attempt to call the function. */
    setdtablesize(1024);
    return 0;
}
