# M4s


Updated M4s by Kellen in 2021.


To run, use:

	1.  make clean_data
	2.  make all
	3.  make in=<input> out=<output> run
	
	where <input> and <output> are optional arguments. input defaults to main.in, output defaults to stdout.

Make sure that in your ~/.bashrc you are exporting the proper PETSC_DIR and PETSC_ARCH
will likely be /usr/lib/petsc-<version> and the arch may be arch-linux-c-debug

The makefile function "run" must be tailored to the specific computer. If hyperthreading is supported, the rankfile must also be tailored.

start.job is solely for running remotely on an hpc supercomputer.
