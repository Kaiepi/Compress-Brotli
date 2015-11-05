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

LIBSO = libperl6brotli.so
LIBA  = $(LIBSO).1
LIBB  = $(LIBSO).1.0.1 

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

library: $(CFLAGS) += -fPIC 
library: $(OBJECTS)
	$(CC) $(DEPENDS) -shared -Wl,$(NAME_LIB),$(LIBA) -o $(LIBB) $^
	ln -sf  $(LIBB) $(LIBSO)
	ln -sf  $(LIBB) $(LIBA)

#============================================
# Results
#============================================

all: library
#	find . -name "*.gcda" -print0 | xargs -0 rm # clean up gcda

#============================================
# Helpers
#============================================

clean:
	$(RM) $(OBJECTS) $(OBJECTS) $(LIBA) $(LIBB)



