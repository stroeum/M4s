# M4s


Updated M4s by Kellen in 2021.


To run, use:

	1.  make clean_data
	2.  make all
	3. "make in=<input> run"
	
	where <input> is the name of the input file located in ./input/ (or, "make run" defaults to use ./input/main.in)

The makefile function "run" must be tailored to the specific computer. If hyperthreading is supported, the rankfile must also be tailored.

start.job is solely for running remotely on an hpc supercomputer.
