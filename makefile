#!/bin/bash
PETSC_DIR = /usr/lib/petsc
#PETSC_ARCH = arch-darwin-c-debug
include $(PETSC_DIR)/lib/petsc/conf/variables
include $(PETSC_DIR)/lib/petsc/conf/rules

SRCDIR := src
BUILDDIR := build
TARGETDIR := bin
TARGET1 := $(TARGETDIR)/M4

#.DEFAULT_GOAL := all
#.PHONY := clean

SRCEXT := c

SOURCES1 := $(wildcard $(SRCDIR)/*.$(SRCEXT))
OBJECTS1 := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES1:.$(SRCEXT)=.o))

CFLAGS := -g -Wall -m64 -Os -Wwrite-strings -Wmissing-declarations -Wuninitialized
COMPILER = mpicc

LIB := \
 	-lpetsc -lmpi -lm -ldl -lc \
	-L$(PETSC_DIR)/lib
 #-static-libgcc

INCLUDE := \
	-Iinclude/ \
	-I$(PETSC_DIR)/include
	#-I$(PETSC_DIR)/$(PETSC_ARCH)/include 

all: $(TARGET1)
	@echo "main srcs: $(SOURCES1)"
	@echo "main objs: $(OBJECTS1)"

run:
ifdef in
ifdef out
	mpiexec -np 12 -H localhost -rf ./rankfile $(TARGET1) -options_file ./input/$(in) > ./output/$(out)
else
	mpiexec -np 12 -H localhost -rf ./rankfile $(TARGET1) -options_file ./input/$(in)
endif
else
ifdef out
	mpiexec -np 12 -H localhost -rf ./rankfile $(TARGET1) -options_file ./input/main.in > ./output/$(out)
else
	mpiexec -np 12 -H localhost -rf ./rankfile $(TARGET1) -options_file ./input/main.in
endif
endif

test:
ifdef in
ifdef out
	@echo "both"
else
	@echo "in"
endif
else
ifdef out
	@echo "out"
else
	@echo "neither"
endif
endif

$(TARGET1): $(OBJECTS1)
	@mkdir -p $(TARGETDIR)
	@echo " Linking..."
	$(COMPILER) $(OBJECTS1) -o $(TARGET1) $(PETSC_LIB) $(LIB)

$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@echo $(PETSC_DIR)
	@mkdir -p $(BUILDDIR)
	$(COMPILER) $(CFLAGS) $(INCLUDE) -c -o $@ $<

clean_data:
	@echo " Cleaning...";
	$(RM) -r $(BUILDDIR) $(TARGETDIR) output/* viz_dir/*
