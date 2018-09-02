CXX=clang++
CXXFLAGS=-std=c++11

FILES=01 02

all: $(FILES)

%: %_main.cpp
	$(CXX) $(CXXFLAGS) -o $@ $<

clean:
	rm $(FILES)
