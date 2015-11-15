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

DESTINATION = ../lib/Compress/
LIBN = libperl6brotli
LIBDY = $(DESTINATION)$(LIBN).dylib
LIBSO = $(DESTINATION)$(LIBN).so
LIBA = $(LIBSO).1
LIBB = $(LIBSO).1.0.1 

#============================================
# Flags
#============================================

CFLAGS = -Wall -std=gnu++11
DEPENDS = -L./libbrotli/lib/ -lbrotlienc -lbrotlidec -lstdc++ 

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
	$(CC) $(CFLAGS) -I./libbrotli/include/ -c -o $@ $<	#TODO parameterize includes

#============================================
# Linking
#============================================

darwin: $(OBJECTS)
	$(CC) $(DEPENDS) -dynamiclib -undefined suppress -flat_namespace $^ -o $(LIBDY)
	#ln -sf ./libperl6brotli.dylib $(DESTINATION)$(LIBN)

linux: CFLAGS += -fPIC
linux: $(OBJECTS)
	$(CC) $(DEPENDS) -shared -Wl,$(NAME_LIB),$(LIBA) -o $(LIBB) $^
	ln -sf  $(LIBB) $(LIBSO)
	ln -sf  $(LIBB) $(LIBA)

#============================================
# Fetch the required dependencies
#============================================
setup:
	./fetch

#============================================
# Results
#============================================

all: setup $(DEF_TARGET)

install:
	

#============================================
# Helpers
#============================================

clean:
	$(RM) $(OBJECTS) $(OBJECTS) $(LIBDY) $(LIBB) $(LIBSO) $(LIBA)
	$(RM) -rf libbrotli



