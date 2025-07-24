/* error_windows.h - Just declare the error function for Windows without getting cute.

Copyright (C) 2025 Free Software Foundation, Inc.

This file is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation; either version 2.1 of the
License, or (at your option) any later version.

This file is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#ifndef _ERROR_WINDOWS_H
#define _ERROR_WINDOWS_H

#ifdef __cplusplus
extern "C" {
#endif

void error(int status, int errnum, const char *format, ...);

#ifdef __cplusplus
}
#endif

#endif /* _ERROR_WINDOWS_H */
