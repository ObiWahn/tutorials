#include <list>
#include <array>
#include <initializer_list>
#include <algorithm>
#include <stdexcept>
#include <iostream>

//implemented below
template<typename T,int Size> struct myarray;
struct dog;


//// extra traits
//list
template<typename T>
struct  optimised_sort_trait<std::list<T>>
{
    static const bool value = true;
};

template<typename T, int Size>
struct  optimised_sort_trait<myarray<T, Size>>
{
    static const bool value = true;
};

template<>
struct  optimised_sort_trait<dog>
{
    static const bool value = true;
};


////Implemenation of Classes

//array
template<typename T,int Size>
struct myarray : public std::array<T, Size>
{
    myarray(): std::array<T,Size>(){}
    myarray(std::initializer_list<T> list): std::array<T,Size>()
    {
        if(list.size()!=Size)
            throw std::out_of_range("wrong number of values in initializer list");
        std::copy(list.begin(), list.end(), this->begin());
    }

    void sort()
    {
        //or some other awesome implementation
        std::sort(this->begin(), this->end());
        std::reverse(this->begin(), this->end());
    }
};









struct dog
{
    void sort() { std::cout << "Woooof! Wuff! гав!" << std::endl; }
};
