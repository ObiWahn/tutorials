#include <vector>
#include <iostream>
#include "02_traits.hpp"
#include "02_main.hpp"
#include "util.hpp"


//main
int main()
{
    std::vector<int> vec{4,3,1,0,8,6,7,2,9,5};
    sort(vec);
    print_container(vec);

    std::list<int> li{4,3,1,0,8,6,7,2,9,5};
    sort(li);
    print_container(li);

    myarray<int,10> arr{4,3,1,0,8,6,7,2,9,5};
    sort(arr);
    print_container(arr);

    dog a_dog;
    sort(a_dog);
}
