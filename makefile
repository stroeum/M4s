#!/bin/bash
include ${PETSC_DIR}/lib/petsc/conf/variables
include ${PETSC_DIR}/lib/petsc/conf/rules

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
#	CC := clang -arch x86_64
else
#	CC := gcc
endif

SRCDIR := src
LIBDIR := lib
BUILDDIR := obj
TARGETDIR := bin
TARGET1 := $(TARGETDIR)/M4
TARGET2 := $(TARGETDIR)/conv

.DEFAULT_GOAL := all
.PHONY := clean

SRCEXT := c
SOURCES := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))

CFLAGS := 
ifeq ($(UNAME_S),Linux)
	CFLAGS += -std=gnu++11 -O2 # -fPIC
else
	#CFLAGS = -g -Wall -m64 -O1 -wd981 -g -Werror -wd593 -Wwrite-strings -Wmissing-declarations -Wuninitialized -Wstrict-prototypes -Wmissing-prototypes -std=c99 -Wshadow
	CFLAGS += -g -Wall -m64 -Os -Wwrite-strings -Wmissing-declarations -Wuninitialized
endif

LIB := #-lm -ldl -lc #-static-libgcc
INC := #-I 

all: ${TARGET1} ${TARGET2}

$(TARGET1): $(OBJECTS) chkopts
	@mkdir -p $(TARGETDIR)
	@echo " Linking..."
	@echo " $(CLINKER) $(OBJECTS) -o $(TARGET1) $(PETSC_LIB) $(LIB)"; $(CLINKER) $(OBJECTS) -o $(TARGET1) ${PETSC_LIB} $(LIB) 

$(TARGET2): $(OBJECTS) chkopts
	@mkdir -p $(TARGETDIR)
	@echo " Linking..."
	@echo " $(CLINKER) $(OBJECTS) -o $(TARGET2) $(PETSC_LIB) $(LIB)"; $(CLINKER) $(OBJECTS) -o $(TARGET2) ${PETSC_LIB} $(LIB) 

$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@echo ${PETSC_DIR}
	@mkdir -p $(BUILDDIR)
	@echo " $(PETSC_COMPILE) $(CFLAGS) $(INC) -c -o $@ $< "; $(PETSC_COMPILE) $(CFLAGS) $(INC) -c -o $@ $<

clear:
	@echo " Cleaning...";
	@echo " $(RM) -r $(BUILDDIR) $(TARGETDIR)"; $(RM) -r $(BUILDDIR) $(TARGETDIR)
