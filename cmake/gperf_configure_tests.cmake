include(CheckCSourceCompiles)
include(CheckCXXSourceCompiles)
include(CheckFunctionExists)
include(CheckIncludeFiles)
include(CheckLibraryExists)
include(CheckSymbolExists)
include(CheckTypeSize)
include(GNUInstallDirs)

message(STATUS "CMAKE_EXECUTABLE_SUFFIX is '${CMAKE_EXECUTABLE_SUFFIX}'.")

set(CHECK_HAVE_DYNAMIC_ARRAY_SOURCE [[
int main(int n)
{
  int dynamic_array[n];
}
]])
check_cxx_source_compiles("${CHECK_HAVE_DYNAMIC_ARRAY_SOURCE}" HAVE_DYNAMIC_ARRAY)

set(CHECK_HAVE_INCLUDE_NEXT_SUPPORT_SOURCE [[
#include_next <stdio.h>
int main()
{
  return 0;
}
]])
check_c_source_compiles("${CHECK_HAVE_INCLUDE_NEXT_SUPPORT_SOURCE}" HAVE_INCLUDE_NEXT_SUPPORT)

if(HAVE_INCLUDE_NEXT_SUPPORT)
  set(INCLUDE_NEXT "include_next")
else()
  set(INCLUDE_NEXT "include")
endif()

set(NEXT_GETOPT_H "<getopt.h>")
set(NEXT_UNISTD_H "<unistd.h>")
set(NEXT_SYS_STAT_H "<sys/stat.h>")

set(CHECK_HAVE_MEMSET_S_SOURCE [[
#define __STDC_WANT_LIB_EXT1__ 1
#include <string.h>
int main()
{
  char buffer[10];
  memset_s(buffer, sizeof(buffer), 0, sizeof(buffer));
  return 0;
}
]])
check_c_source_compiles("${CHECK_HAVE_MEMSET_S_SOURCE}" HAVE_MEMSET_S)

set(CHECK_HAVE_DECL_STRERROR_R_SOURCE [[
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
]])
check_c_source_compiles("${CHECK_HAVE_DECL_STRERROR_R_SOURCE}" HAVE_DECL_STRERROR_R)

set(CHECK_HAVE_WCSDUP_SOURCE [[
#include <wchar.h>
#include <stdlib.h>
int main()
{
  const wchar_t* original = L\"Hello\";
  wchar_t* duplicated = wcsdup(original);
  if (duplicated)
  {
    free(duplicated);
  }
  return 0;
}
]])
check_c_source_compiles("${CHECK_HAVE_WCSDUP_SOURCE}" HAVE_WCSDUP)
check_c_source_compiles("${CHECK_HAVE_WCSDUP_SOURCE}" HAVE_DECL_WCSDUP)

check_function_exists(error HAVE_ERROR)
check_function_exists(error_at_line HAVE_ERROR_AT_LINE)
check_function_exists(getprogname HAVE_GETPROGNAME)
check_function_exists(memset_explicit HAVE_MEMSET_EXPLICIT)

check_include_files("alloca.h" HAVE_ALLOCA_H)
check_include_files("crtdefs.h" HAVE_CRTDEFS_H)
check_include_files("error.h" HAVE_ERROR_H)
check_include_files("features.h" HAVE_FEATURES_H)
check_include_files("getopt.h" HAVE_GETOPT_H)
check_include_files("inttypes.h" HAVE_INTTYPES_H)
check_include_files("limits.h" HAVE_LIMITS_H)
check_include_file("langinfo.h" HAVE_LANGINFO_H)
check_include_files("stdckdint.h" HAVE_STDCKDINT_H)
check_include_files("sdkddkver.h" HAVE_SDKDDKVER_H)
check_include_files("stdbool.h" HAVE_STDBOOL_H)
check_include_files("stddef.h" HAVE_STDDEF_H)
check_include_files("stdint.h" HAVE_STDINT_H)
check_include_files("stdio.h" HAVE_STDIO_H)
check_include_files("stdlib.h" HAVE_STDLIB_H)
check_include_files("string.h" HAVE_STRING_H)
check_include_files("strings.h" HAVE_STRINGS_H)
check_include_files("unistd.h" HAVE_UNISTD_H)
check_include_files("wchar.h" HAVE_WCHAR_H)
check_include_files("winsock2.h" HAVE_WINSOCK2_H)
check_include_files("xlocale.h" HAVE_XLOCALE_H)
check_include_files("minix/config.h" HAVE_MINIX_CONFIG_H)
check_include_files("sys/bitypes.h" HAVE_SYS_BITYPES_H)
check_include_files("sys/cdefs.h" HAVE_SYS_CDEFS_H)
check_include_files("sys/inttypes.h" HAVE_SYS_INTTYPES_H)
check_include_files("sys/param.h" HAVE_SYS_PARAM_H)
check_include_files("sys/socket.h" HAVE_SYS_SOCKET_H)
check_include_files("sys/stat.h" HAVE_SYS_STAT_H)
check_include_files("sys/time.h" HAVE_SYS_TIME_H)
check_include_files("sys/types.h" HAVE_SYS_TYPES_H)

check_symbol_exists("CODESET" "langinfo.h" HAVE_CODESET)
check_symbol_exists("nl_langinfo" "langinfo.h" HAVE_NL_LANGINFO)
check_symbol_exists(alloca "alloca.h;stdlib.h;malloc.h" HAVE_ALLOCA)
check_symbol_exists(explicit_memset "string.h" HAVE_EXPLICIT_MEMSET)
check_symbol_exists(fcntl "fcntl.h" HAVE_FCNTL)
check_symbol_exists(ftello "stdio.h" HAVE_DECL_FTELLO)
check_symbol_exists(getexecname "stdlib.h" HAVE_GETEXECNAME)
check_symbol_exists(lstat "sys/stat.h" HAVE_LSTAT)
check_symbol_exists(xalloc_die "stdlib.h" HAVE_XALLOC_DIE)


check_type_size(ptrdiff_t BITSIZEOF_PTRDIFF_T)
check_type_size(size_t BITSIZEOF_SIZE_T)
check_type_size(wchar_t BITSIZEOF_WCHAR_T)

set(CMAKE_EXTRA_INCLUDE_FILES signal.h stdio.h stdint.h)
set(CHECK_HAVE_SIGNED_SIG_ATOMIC_T_SOURCE [[
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
]])
check_type_size("sig_atomic_t" BITSIZEOF_SIG_ATOMIC_T)
check_type_size("sig_atomic_t" HAVE_SIG_ATOMIC_T)
if(HAVE_SIG_ATOMIC_T)
  # Check if sig_atomic_t is signed
  message(STATUS "Checking if sig_atomic_t is signed...")
  set(CMAKE_C_FLAGS_ORIGINAL "${CMAKE_C_FLAGS}")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DSIG_ATOMIC_MIN_CHECK")
  set(HAVE_SIGNED_SIG_ATOMIC_T_SOURCE_FILE "${CMAKE_CURRENT_BINARY_DIR}/check_sig_atomic_signed.c")
  set(HAVE_SIGNED_SIG_ATOMIC_T_OUTPUT_FILE "${CMAKE_CURRENT_BINARY_DIR}/check_sig_atomic_signed${CMAKE_EXECUTABLE_SUFFIX}")
  file(WRITE "${HAVE_SIGNED_SIG_ATOMIC_T_SOURCE_FILE}" "${CHECK_HAVE_SIGNED_SIG_ATOMIC_T_SOURCE}")
  # Compile and run the C program
  execute_process(COMMAND ${CMAKE_C_COMPILER} "${HAVE_SIGNED_SIG_ATOMIC_T_SOURCE_FILE}" -o "${HAVE_SIGNED_SIG_ATOMIC_T_OUTPUT_FILE}")
  if(EXISTS "${HAVE_SIGNED_SIG_ATOMIC_T_OUTPUT_FILE}")
    execute_process(
      COMMAND "${HAVE_SIGNED_SIG_ATOMIC_T_OUTPUT_FILE}"
      RESULT_VARIABLE SIG_ATOMIC_RESULT
      OUTPUT_VARIABLE SIG_ATOMIC_SIGNED_OUTPUT
      ERROR_QUIET
      OUTPUT_STRIP_TRAILING_WHITESPACE
      ERROR_STRIP_TRAILING_WHITESPACE)
    if(SIG_ATOMIC_RESULT)
      message(FATAL_ERROR "Failed to run the sig_atomic_t signed check program.")
    else()
      string(STRIP "${SIG_ATOMIC_SIGNED_OUTPUT}" SIG_ATOMIC_SIGNED_OUTPUT)
      message(STATUS "sig_atomic_t signed check output: ${SIG_ATOMIC_SIGNED_OUTPUT}")
    endif()
  else()
    message(FATAL_ERROR "Source file for sig_atomic_t signed check does not exist.")
  endif()
  # Set a CMake variable based on the output
  if("${SIG_ATOMIC_SIGNED_OUTPUT}" STREQUAL "SIGNED")
    set(HAVE_SIGNED_SIG_ATOMIC_T 1)
    message(STATUS "sig_atomic_t is signed.")
  else()
    set(HAVE_SIGNED_SIG_ATOMIC_T 0)
    message(STATUS "sig_atomic_t is unsigned.")
  endif()
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS_ORIGINAL}")
endif()
unset(CMAKE_EXTRA_INCLUDE_FILES)

set(CMAKE_EXTRA_INCLUDE_FILES wchar.h)
check_type_size(wint_t BITSIZEOF_WINT_T)
check_type_size(wint_t HAVE_WINT_T)
unset(CMAKE_EXTRA_INCLUDE_FILES)

if(HAVE_DECL_FTELLO)
  set(CHECK_HAVE_DECL_FTELLO_SOURCE [[
  #include <stdio.h>
  int main()
  {
    FILE *fp = fopen(\"test.txt\", \"w\");
    if (fp)
    {
      ftello(fp);
      fclose(fp);
    }
    return 0;
  }
  ]])
  check_c_source_compiles("${CHECK_HAVE_DECL_FTELLO_SOURCE}" HAVE_FTELLO)
else()
  set(HAVE_DECL_FTELLO 0)
endif()

if(HAVE_GETOPT_H)
  check_function_exists(getopt HAVE_GETOPT)
  check_function_exists(getopt_long_only HAVE_GETOPT_LONG_ONLY)
endif()

set(CMAKE_REQUIRED_FLAGS "-D_GNU_SOURCE=1")
check_symbol_exists(execvpe "unistd.h" HAVE_DECL_EXECVPE)
unset(CMAKE_REQUIRED_FLAGS)
if(HAVE_DECL_EXECVPE)
  set(_GNU_SOURCE 1)
endif()

set(CMAKE_REQUIRED_FLAGS "-D_GNU_SOURCE=1")
check_symbol_exists(fcloseall "stdio.h" HAVE_DECL_FCLOSEALL)
unset(CMAKE_REQUIRED_FLAGS)
if(HAVE_DECL_FCLOSEALL)
  set(_GNU_SOURCE 1)
endif()

set(CMAKE_REQUIRED_FLAGS "-D_POSIX_C_SOURCE=200809L")
check_symbol_exists(ecvt "stdlib.h" HAVE_DECL_ECVT)
check_symbol_exists(fcvt "stdlib.h" HAVE_DECL_FCVT)
check_symbol_exists(gcvt "stdlib.h" HAVE_DECL_GCVT)
check_symbol_exists(getdtablesize "unistd.h" HAVE_DECL_GETDTABLESIZE)
check_symbol_exists(getw "stdlib.h" HAVE_DECL_GETW)
check_symbol_exists(putw "stdlib.h" HAVE_DECL_PUTW)
unset(CMAKE_REQUIRED_FLAGS)
if(HAVE_DECL_ECVT OR HAVE_DECL_FCVT OR HAVE_DECL_GCVT OR HAVE_DECL_GETDTABLESIZE OR HAVE_DECL_GETW OR HAVE_DECL_PUTW)
  set(_POSIX_C_SOURCE 200809L)
endif()

if(HAVE_LANGINFO_H AND HAVE_NL_LANGINFO AND HAVE_CODESET)
  set(HAVE_LANGINFO_CODESET 1)
else()
  set(HAVE_LANGINFO_CODESET 0)
endif()

if(MSVC)
  if (MSVC_TOOLSET_VERSION GREATER_EQUAL 140)
    set(HAVE_MSVC_INVALID_PARAMETER_HANDLER 1)
    set(HAVE__SET_INVALID_PARAMETER_HANDLER 1)
  else()
    set(HAVE_MSVC_INVALID_PARAMETER_HANDLER 0)
    set(HAVE__SET_INVALID_PARAMETER_HANDLER 0)
  endif()
else()
  set(HAVE_MSVC_INVALID_PARAMETER_HANDLER 0)
  set(HAVE__SET_INVALID_PARAMETER_HANDLER 0)
endif()

if(WIN32)
  set(DOUBLE_SLASH_IS_DISTINCT_ROOT 1)
else()
  set(DOUBLE_SLASH_IS_DISTINCT_ROOT 0)
endif()

if(NOT HAVE_MEMSET_EXPLICIT AND WIN32)
  set(USE_SIMPLE_MEMSET_EXPLICIT_DECL 1)
else()
  set(USE_SIMPLE_MEMSET_EXPLICIT_DECL 0)
endif()

if(NOT HAVE_XALLOC_DIE)
  set(GNULIB_XALLOC_DIE 1)
else()
  set(GNULIB_XALLOC_DIE 0)
endif()

if(NOT HAVE_ALLOCA_H)
  set(HAVE_ALLOCA_H 0)
endif()
if(NOT HAVE_CODESET)
  set(HAVE_CODESET 0)
endif()
if(NOT HAVE_CRTDEFS_H)
  set(HAVE_CRTDEFS_H 0)
endif()
if(NOT HAVE_DECL_ECVT)
  set(HAVE_DECL_ECVT 0)
endif()
if(NOT HAVE_DECL_EXECVPE)
  set(HAVE_DECL_EXECVPE 0)
endif()
if(NOT HAVE_DECL_FCLOSEALL)
  set(HAVE_DECL_FCLOSEALL 0)
endif()
if(NOT HAVE_DECL_FCVT)
  set(HAVE_DECL_FCVT 0)
endif()
if(NOT HAVE_DECL_FTELLO)
  set(HAVE_DECL_FTELLO 0)
endif()
if(NOT HAVE_DECL_GCVT)
  set(HAVE_DECL_GCVT 0)
endif()
if(NOT HAVE_DECL_GETDTABLESIZE)
  set(HAVE_DECL_GETDTABLESIZE 0)
endif()
if(NOT HAVE_DECL_GETW)
  set(HAVE_DECL_GETW 0)
endif()
if(NOT HAVE_DECL_PUTW)
  set(HAVE_DECL_PUTW 0)
endif()
if(NOT HAVE_DECL_WCSDUP)
  set(HAVE_DECL_WCSDUP 0)
endif()
if(NOT HAVE_ERROR)
  set(HAVE_ERROR 0)
endif()
if(NOT HAVE_ERROR_AT_LINE)
  set(HAVE_ERROR_AT_LINE 0)
endif()
if(NOT HAVE_ERROR_H)
  set(HAVE_ERROR_H 0)
endif()
if(NOT HAVE_EXPLICIT_MEMSET)
  set(HAVE_EXPLICIT_MEMSET 0)
endif()
if(NOT HAVE_FCNTL)
  set(HAVE_FCNTL 0)
endif()
if(NOT HAVE_FEATURES_H)
  set(HAVE_FEATURES_H 0)
endif()
if(NOT HAVE_FTELLO)
  set(HAVE_FTELLO 0)
endif()
if(NOT HAVE_GETEXECNAME)
  set(HAVE_GETEXECNAME 0)
endif()
if(NOT HAVE_GETOPT_H)
  set(HAVE_GETOPT_H 0)
endif()
if(NOT HAVE_GETPROGNAME)
  set(HAVE_GETPROGNAME 0)
endif()
if(NOT HAVE_INTTYPES_H)
  set(HAVE_INTTYPES_H 0)
endif()
if(NOT HAVE_LANGINFO_H)
  set(HAVE_LANGINFO_H 0)
endif()
if(NOT HAVE_LIMITS_H)
  set(HAVE_LIMITS_H 0)
endif()
if(NOT HAVE_LSTAT)
  set(HAVE_LSTAT 0)
endif()
if(NOT HAVE_MEMSET_EXPLICIT)
  set(HAVE_MEMSET_EXPLICIT 0)
endif()
if(NOT HAVE_NL_LANGINFO)
  set(HAVE_NL_LANGINFO 0)
endif()
if(NOT HAVE_STDCKDINT_H)
  set(HAVE_STDCKDINT_H 0)
endif()
if(NOT HAVE_SDKDDKVER_H)
  set(HAVE_SDKDDKVER_H 0)
endif()
if(NOT HAVE_SIG_ATOMIC_T)
  set(HAVE_SIG_ATOMIC_T 0)
endif()
if(NOT HAVE_STDBOOL_H)
  set(HAVE_STDBOOL_H 0)
endif()
if(NOT HAVE_STDDEF_H)
  set(HAVE_STDDEF_H 0)
endif()
if(NOT HAVE_STDINT_H)
  set(HAVE_STDINT_H 0)
endif()
if(NOT HAVE_STDIO_H)
  set(HAVE_STDIO_H 0)
endif()
if(NOT HAVE_STDLIB_H)
  set(HAVE_STDLIB_H 0)
endif()
if(NOT HAVE_STRING_H)
  set(HAVE_STRING_H 0)
endif()
if(NOT HAVE_STRINGS_H)
  set(HAVE_STRINGS_H 0)
endif()
if(NOT HAVE_MINIX_CONFIG_H)
  set(HAVE_MINIX_CONFIG_H 0)
endif()
if(NOT HAVE_SYS_BITYPES_H)
  set(HAVE_SYS_BITYPES_H 0)
endif()
if(NOT HAVE_SYS_CDEFS_H)
  set(HAVE_SYS_CDEFS_H 0)
endif()
if(NOT HAVE_SYS_INTTYPES_H)
  set(HAVE_SYS_INTTYPES_H 0)
endif()
if(NOT HAVE_SYS_PARAM_H)
  set(HAVE_SYS_PARAM_H 0)
endif()
if(NOT HAVE_SYS_SOCKET_H)
  set(HAVE_SYS_SOCKET_H 0)
endif()
if(NOT HAVE_SYS_STAT_H)
  set(HAVE_SYS_STAT_H 0)
endif()
if(NOT HAVE_SYS_TIME_H)
  set(HAVE_SYS_TIME_H 0)
endif()
if(NOT HAVE_SYS_TYPES_H)
  set(HAVE_SYS_TYPES_H 0)
endif()
if(NOT HAVE_UNISTD_H)
  set(HAVE_UNISTD_H 0)
endif()
if(NOT HAVE_WCHAR_H)
  set(HAVE_WCHAR_H 0)
endif()
if(NOT HAVE_WCSDUP)
  set(HAVE_WCSDUP 0)
endif()
if(NOT HAVE_WINSOCK2_H)
  set(HAVE_WINSOCK2_H 0)
endif()
if(NOT HAVE_XALLOC_DIE)
  set(HAVE_XALLOC_DIE 0)
endif()
if(NOT HAVE_XLOCALE_H)
  set(HAVE_XLOCALE_H 0)
endif()
