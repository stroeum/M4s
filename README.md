# M4s

Updated M4s by Kellen in 2021.


## Before running
Make sure that in your ~/.bashrc you are exporting the proper PETSC_DIR and PETSC_ARCH
	Locally: petsc_dir ~= /usr/lib/petsc-<version>  and  petsc_arch ~= arch-linux-c-debug
	Blueshark: petsc_dir ~= export/spack/linux-centos7-x86_64/gcc-9.1.0/petsc-...

The makefile function "run" must be tailored to the specific computer. If hyperthreading is supported, the rankfile must also be tailored.


## Commands to run

	1.  make clean_data
	2.  make all
	3.  make in=<input> out=<output> run
	where <input> and <output> are optional arguments. input defaults to main.in, output defaults to stdout.

	Or, if on blueshark
	1. sbatch start.job


## Debugging information

Seg faults:
	Most likely due to hardcoded directory pointing to the wrong place.
	The output, bin, and build directories must exist prior to running the mpiexec
	The input file, myctx.c, and the makefile contain hardcoded directory pointers, test these.
	This also depends where the program is being run from. Should be /M4s, not /M4s/bin

btl_tcp error on BlueShark:
	This occurs when the program is attempting to run on >1 node. You need to add command-line arguments to mpiexec that look similar to
	-mca btl_tcp_if_include eno1 -mca btl tcp,self
	The eno1 can be located using the ifconfig command. Beyond this, I don't know much about the error

Problem during Linking as part of "make all"
	May need to link a library using "sudo ln -s <library you do have> <library it's looking for and failing to find>
	Ex: sudo ln -s /usr/lib/python3 /usr/lib/python
