#include <stdint.h>
#include <wchar.h>
#include <wctype.h>

#include <iostream>
#include <type_traits>

int main()
{
    if (std::is_signed<wint_t>::value)
    {
        std::cout << "wint_t_is_signed";
    }
    else
    {
        std::cout << "wint_t_is_unsigned";
    }
    return 0;
}
