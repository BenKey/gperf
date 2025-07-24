/* Program name management.
Copyright (C) 2025 Free Software Foundation, Inc.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

#include <config.h>

#include <windows.h>
#include <string.h>

const char *getprogname(void)
{
  static char progname[MAX_PATH];
  DWORD length = GetModuleFileNameA(NULL, progname, MAX_PATH);
  if (length == 0 || length == MAX_PATH)
  {
    // Failed to get the program name
    return NULL; 
  }
  // Extract the base name from the full path
  const char *basename = strrchr(progname, '\\');
  return basename ? basename + 1 : progname;
}
