#include <algorithm>

//trait
template<typename T>
struct optimised_sort_trait
{
    static const bool value = false;
};

//selector that uses the trait
//default behavior
template<bool Bool>
struct selector
{
    template<typename T>
    static void sort_implementation(T& container)
    {
        std::cout << "calling std::sort" << std::endl;
        std::sort(container.begin(),container.end());
    }
};

//specialised behavior - if the parameter of the meta template function is true
template<>
struct selector<true>
{
    template<typename T>
    static void sort_implementation(T& container)
    {
        std::cout << "calling specialized sort" << std::endl;
        container.sort();
    }
};

//define sort function that uses the selector
template<typename T>
void sort(T& container)
{
    selector<optimised_sort_trait<T>::value>::sort_implementation(container);
}
