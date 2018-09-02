#include <iostream>
template<typename C>
void print_container(const C& container)
{
    for (auto item : container){ std::cout << item; }
    std::cout << std::endl;
}
