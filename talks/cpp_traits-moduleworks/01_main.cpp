#include <iostream>
#include "01_traits.hpp"

int main()
{
    std::cout << "is_void_trait<void>    : " << is_void_trait<void>::value     << std::endl;
    std::cout << "is_void_trait<double>  : " << is_void_trait<double>::value   << std::endl;
    std::cout << "is_void_trait<int>     : " << is_void_trait<int>::value      << std::endl;

    std::cout << "is_same_trait<void,int>: " << is_same_trait<void,int>::value << std::endl;
    std::cout << "is_same_trait<int,int> : " << is_same_trait<int,int>::value  << std::endl;

    std::cout << "is_int_trait<double>   : " << is_int_trait<double>::value    << std::endl;
    std::cout << "is_int_trait<int>      : " << is_int_trait<int>::value       << std::endl;

    std::cout << "is_pointer_trait<int>  : " << is_pointer_trait<int>::value   << std::endl;
    std::cout << "is_pointer_trait<int*> : " << is_pointer_trait<int*>::value  << std::endl;
}
