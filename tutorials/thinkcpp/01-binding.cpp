#include <iostream>
#include <string>
using namespace std;

struct base
{
    virtual void foo(string s = "default param form base")
    {
        cout << "base: " << s << endl;
    }
};

struct derived : public base
{
    void foo(string s = "default param form derived")
    {
        cout << "derived: " << s << endl;
    }
};

int main()
{
    base b;
    derived d;
    base* b_ptr = new derived;

    b.foo();
    d.foo();
    b_ptr->foo();

    return 0;
}
