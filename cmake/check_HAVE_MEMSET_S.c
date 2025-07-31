#define __STDC_WANT_LIB_EXT1__ 1
#include <string.h>

int main()
{
  char buffer[10];
  memset_s(buffer, sizeof(buffer), 0, sizeof(buffer));
  return 0;
}
