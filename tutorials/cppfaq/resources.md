# C++ Resources
This FAQ turned more into a document that gathers information
about c++ and serves as a reference for me and and friends.

A real [FAQ](faq.md) will be added at a later point in time!

## Language Resources

### Urls
 * [isocpp](https://isocpp.org/) -
   iso c++ committee page
 * [cpp reference](http://en.cppreference.com/w/) -
   the ultimate reference
 * [c++ standard](http://eelis.net/c++draft/) -
   a current draft of the standard
 * [core guide lines](https://github.com/isocpp/CppCoreGuidelines) -
   guidelines by Stroustrup and Sutter

### Books
#### Basic
 * C++ Primer
   (Stanley Lippman, Josée Lajoie, and Barbara E. Moo) -
   complete introduction
 * Accelerated C++
   (Andrew Koenig and Barbara Moo) -
   a bit outdated but compact
 * A Tour of C++
   (Bjarne Stroustrup) -
   quick overview
 * Effective Modern C++
   (Scott Myers)
 * C++ Concurrency in Action
   (Anthony Williams) -
   introduction to multi-threading

#### Advanced
 * From Mathematics to Generic Programming - Alexander A. Stepanov and Daniel E. Rose
 * Elements of Programming - Alexander A. Stepanov and Paul McJones

### Videos
 * [seasoning c++](
   https://channel9.msdn.com/Events/GoingNative/2013/Cpp-Seasoning) -
   Sean Parent
 * [Modern Template Metaprogramming: A Compendium part1](
   https://www.youtube.com/watch?v=Am2is2QCvxY) /
   [part2](https://www.youtube.com/watch?v=a0FliKwcwXE) -
   Walter E. Brown
 * [Lockfree Programming](
   https://www.youtube.com/watch?v=c1gO9aB9nbs) -
   Herb Sutter
 * chandler
 * 4 journeys

### Libs
The libraries named here are interesting to me. There are lots and lots
of other cool libraries. I strongly recommend to explore what serves
your needs best

#### Test
 * google test
 * catch

#### Boost

#### More
* brigand -
  functional meta programming
* [eigen](
  eigen.tuxfamily.org) -
  linear algebra
* [range v3](
  https://github.com/ericniebler/range-v3) - 
  better ranges
* [Kvasir](
  https://github.com/kvasir-io/Kvasir) -
  meta / micro controllers

### Compiler
 * gcc
 * clang

## Tooling
It is a shame that may people neglect the tools, concepts of library design and
separation and [lesser languages](lesser_languages.md) in general. The
ignorance results often in hilarious build times and unstable builds when it
comes to dealing with more than one platform. Time you spent here is not
wasted! You will save yourself and colleagues from a world of pain if you
invest here.

### Debug
Some people claim that debugging is useless because you can write working code in
the first place. They might be right, but when it comes to working and understanding
other peoples code a debugging becomes a very useful skill that must be practised.

#### GDB
GDB is the most common debugger available on linux. Most other debugging solutions
are GDB based.

#### rr (reverse debugging)
rr is an instruction recording, replaying and debugging tool. It adds reverse
continue/next/step to GDB. The addition commands make the debugging process at
aleast 10 times faster, because there is not more careful forward stepping
necessary. Instead you start right at the error and have the option to see what
lead to the situation.


#### Adress Sanaitizer (asan)
The [AdressSanitizer](
https://github.com/google/sanitizers/wiki/AddressSanitizer)
is a library that detects, when compiled into your code, memory erros at
runtime. It has a very small overhead and will let you run your application at
almost full speed.

#### Valgrind
[Valgrind](
http://valgrind.org/) 
is a set of debugging and profiling tools build on top of a virtual machine. It
allows you to find tricky bugs at the cost of execution speed.


### Build

#### Make
#### Cmake
boost build, auto tools, ninja, scons

### Test
Code that is not tested does not exist!

#### Analyser

##### Compiler
One of the best checks can be done by your compiler. All you need to do is to
enable warnings!

#### CI
##### travis
##### jenkins

### Library Design / Linking

