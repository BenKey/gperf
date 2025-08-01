#include <iostream>
#include <type_traits>

int main()
{
    if (std::is_signed<wchar_t>::value)
    {
        std::cout << "wchar_t_is_signed";
    }
    else
    {
        std::cout << "wchar_t_is_unsigned";
    }
    return 0;
}
