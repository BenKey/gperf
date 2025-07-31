#include <wchar.h>
#include <stdlib.h>

int main()
{
  const wchar_t* original = L"Hello";
  wchar_t* duplicated = wcsdup(original);
  if (duplicated)
  {
    free(duplicated);
  }
  return 0;
}
