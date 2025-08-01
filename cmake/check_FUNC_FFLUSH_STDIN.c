#include <stdio.h>
#include <string.h>

int main(int argc, char* argv[])
{
    if (argc < 2)
    {
        fprintf(stderr, "Usage: %s <test_file>\n", argv[0]);
        return 1;
    }
    char* test_file = argv[1];
    if (test_file == NULL || *test_file == 0)
    {
        fprintf(stderr, "Error: Test file name is empty.\n");
        return 1;
    }
    /* Redirect stdin to the test file. */
    FILE* file = freopen(test_file, "r", stdin);
    if (file == NULL)
    {
        fprintf(stderr, "Error: Could not redirect stdin to %s.\n", test_file);
        return 1;
    }
    char buffer[256];
    memset(buffer, 0, sizeof(buffer));
    char* result = fgets(buffer, sizeof(buffer), stdin);
    if (result == NULL)
    {
        fprintf(stderr, "Error: Could not read from stdin.\n");
        return 1;
    }
    /* Flush stdin (if it works on this system). */
    fflush(stdin);
    /* Try to read again; if fflush worked, this should be empty. */
    memset(buffer, 0, sizeof(buffer));
    result = fgets(buffer, sizeof(buffer), stdin);
    if (result != NULL)
    {
        fprintf(stdout, "FFLUSH_FAILURE\n");
        return 0;
    }
    fprintf(stdout, "FFLUSH_SUCCESS\n");
    return 0;
}
