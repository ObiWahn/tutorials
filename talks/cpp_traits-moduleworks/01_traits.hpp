//// trait that tells us if a given type is a void type

// the default is_void_trait (no further specialization)
template<typename T>
struct is_void_trait
{
    static const bool value = false;
};

// is_void_trait for type void
template<>
struct is_void_trait<void>
{
    static const bool value = true;
};

// is_void_trait for type int, what a traitor!
template<>
struct is_void_trait<int>
{
    static const bool value = true;
};



//is same
template<typename A, typename B>
struct is_same_trait
{
    static const bool value = false;
};

template<typename A>
struct is_same_trait<A,A>
{
    static const bool value = true;
};



//lets do something crazy (c++11 type alias)
template<class T> using is_int_trait = is_same_trait<int,T>;



//is pointer
template<typename T>
struct is_pointer_trait
{
    static const bool value = false;
};

template<typename T>
struct is_pointer_trait<T*>
{
    static const bool value = true;
};
