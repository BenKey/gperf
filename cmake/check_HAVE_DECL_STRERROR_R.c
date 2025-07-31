#include <string.h>
#include <errno.h>

int main()
{
  char buffer[1024];
  // This will not compile if strerror_r does not return an int
  int result = strerror_r(EACCES, buffer, sizeof(buffer));
  (void)result; // Suppress unused variable warning
  return 0;
}
