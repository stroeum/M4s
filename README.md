# M4s

Updated M4s by Kellen in 2021.


## Before running
Make sure that in your ~/.bashrc you are exporting the proper PETSC_DIR and PETSC_ARCH
	Locally: petsc_dir ~= /usr/lib/petsc-<version>  and  petsc_arch ~= arch-linux-c-debug
	Blueshark: petsc_dir ~= export/spack/linux-centos7-x86_64/gcc-9.1.0/petsc-...

The makefile function "run" must be tailored to the specific computer. If hyperthreading is supported, the rankfile must also be tailored.

Make sure the mpirun/mpiexec command is run from the root directory. The files that affect the running location are the input file (output and viz_dir directories), in myctx.c, and in the makefile


## Commands to run

	1.  make clean_data
	2.  make all
	3.  make in=<input> out=<output> run
	where <input> and <output> are optional arguments. input defaults to main.in, output defaults to stdout.

	Or, if on blueshark
	1. sbatch start.job


