#include <iostream>
#include <libobi/util/tracking_class.hpp>
using namespace obi::util;

tracking_class<int> fibonacci_01(int n)
{
    if (n < 2) {
        return tracking_class<int>(1); //path1
    } else {
        int a = 1, b = 1;
        for (int i = 2; i < n; i++)
        {
            int c = a + b;
            a = b;
            b = c;
        }
        return tracking_class<int>(b); //path2
    }
}


tracking_class<int> fibonacci_02(int n)
{
    tracking_class<int> rv;            // default ctor

    if (n < 2){
        rv.set_value(1);               // path1
    } else {
        int a = 1, b = 1;
        for (int i = 2; i < n; i++)
        {
            int c = a + b;
            a = b;
            b = c;
        }
        rv.set_value(b);               // path2
    }
    return rv;
}

tracking_class<int> fibonacci_03(int n)
{
    if (n < 2){
        return tracking_class<int>(1); // path1
    } else {
        tracking_class<int> rv;
        int a = 1, b = 1;
        for (int i = 2; i < n; i++)
        {
            int c = a + b;
            a = b;
            b = c;
        }
        rv.set_value(b);               // path2
        return rv;
    }
}

tracking_class<int> fibonacci_04(int n)
{
    if (n < 2){
        return tracking_class<int>(1); // path1
    } else {
        tracking_class<int> rv;
        int a = 1, b = 1;
        for (int i = 2; i < n; i++)
        {
            int c = a + b;
            a = b;
            b = c;
        }
        rv.set_value(b);               // path2
        return std::move(rv);
    }
}

#define TEST(num, msg) do { { \
    cout << "Test " #num  " (" #msg "):" << endl; \
    auto t = fibonacci_## num (10); \
    } \
    cout << endl; \
} while(0);


int main()
{
    using namespace std;

    TEST(01,RVO);
    TEST(02,NRVO);
    TEST(03,fuckup 1);
    TEST(04,fuckup 2);
}
