#include <stdio.h>

int main()
{
    FILE *fp = fopen("test.txt", "w");
    if (fp)
    {
        ftello(fp);
        fclose(fp);
    }
    return 0;
}
