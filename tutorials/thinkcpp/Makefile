CPPFLAGS =-std=c++14 -I.. -lpthread

#below all example files are listed
define unstripped_files =

functional
function_cache
scoped_timer
type_to_string
static_lambda
meta

endef
#main_multi_array

files = $(basename $(wildcard *cpp))
.PHONY: clean

all: $(files)
clean:
	rm -fr $(files)
