#########################################
#     Custom MakeFile                   #
# By Adriaan Larmuseau                  #
#########################################

#============================================
# Tools
#============================================

LD = gcc
CC = gcc
SHELL := /bin/bash

#============================================
# Platform specific settings
#============================================
all:

uname_S = $(shell sh -c 'uname -s 2>/dev/null || echo not')

ifeq ($(uname_S),Darwin)
 	DEF_TARGET = darwin	
	NAME_LIB = -install_name
	LD = clang
	CC = clang
endif

ifeq ($(uname_S),Linux)
	DEF_TARGET = linux
	NAME_LIB = -soname
endif

#============================================
# Linkable Targets
#============================================

LIBN = libperl6brotli.dylib
LIBM = /usr/local/lib/$(LIBN)
LIBA = $(LIBSO).1
LIBB = $(LIBSO).1.0.1 

#============================================
# Flags
#============================================

CFLAGS = -Wall 
DEPENDS = -L/usr/local/lib -lbrotlienc -lbrotlidec -lstdc++

#============================================
# Compilation sources
#============================================

# compile all c files in buildsrc
SOURCE=$(wildcard *.cpp)
OBJECTS= $(SOURCE:.cpp=.o) 

#============================================
# Compiling Objects
#============================================

%.o: %.cpp
	$(CC) $(CFLAGS) -I/usr/local/include -c -o $@ $<	#TODO parameterize includes

#============================================
# Linking
#============================================

library: $(OBJECTS)
	$(CC) $(DEPENDS) -dynamiclib -undefined suppress -flat_namespace $^ -o $(LIBN)
#	$(CC) $(DEPENDS) -shared -Wl,$(NAME_LIB),$(LIBA) -o $(LIBB) $^
	-rm $(LIBM)
	ln -sf ~/Dropbox/Projects/perl6/compress-brotli/stub/libperl6brotli.dylib $(LIBM)
#	ln -sf  $(LIBB) $(LIBA)


#============================================
# Fetch the required dependencies
#============================================
setup:
	git clone https://github.com/bagder/libbrotli
	`cd libbrotli; ./autogen.sh; ./configure`
	make -C libbrotli
	make install -C Libbrotli

#============================================
# Results
#============================================

all: library

install:
	
#	find . -name "*.gcda" -print0 | xargs -0 rm # clean up gcda

#============================================
# Helpers
#============================================

clean:
	$(RM) $(OBJECTS) $(OBJECTS) $(LIBN) $(LIBB)



