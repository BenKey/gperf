#include <signal.h>
#include <stdint.h>
#include <stdio.h>

int main()
{
  if (SIG_ATOMIC_MIN < 0)
  {
    printf("SIGNED");
  }
  else
  {
    printf("UNSIGNED");
  }
  return 0;
}
