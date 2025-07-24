#include <errno.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void error(int status, int errnum, const char *format, ...)
{
  va_list args;
  va_start(args, format);

  // Print program name (optional, could be passed as an argument or global)
  fprintf(stderr, "Program: "); // Replace with actual program name or variable
  vfprintf(stderr, format, args);

  if (errnum != 0)
  {
    fprintf(stderr, ": %s", strerror(errnum));
  }
  fprintf(stderr, "\n");
  va_end(args);
  if (status != 0)
  {
    exit(status);
  }
}
