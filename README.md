# Memory-Aware Cache DOS Attacks

This repository contains code for recreating the experimental results in our paper "Memory-Aware Denial-of-Service Attacks on Shared Cache in Multicore Real-Time Systems", which can be found at https://arxiv.org/abs/2005.10864.

Note that we only provide code for the experiments run with a synthetic workload as the victim task.

## Allocate HugePages

	$ sudo bash
	# echo 200 > /proc/sys/vm/nr_hugepages
	# cat /proc/meminfo
	# exit

## Initialize the IsolBench directory

	$ cd MemoryAwareDOS
	$ git submodule update --init
	$ git submodule update --recursive

Before building and installing the IsolBench benchmarks, change the dram_bitmask
value in IsolBench/bench/attacker3.cpp to match the address mapping bitmask of
the target platform. For example, on the Pi 4, dram_bitmask should be set as
follows:

	(line 74) static unsigned long dram_bitmask = 0x7900;
	
Once set, build and install the necessary IsolBench benchmarks with:
	
	$ cd IsolBench/bench
	$ make bandwidth latency-mlp attacker3
	$ sudo cp bandwidth latency-mlp attacker3 /usr/bin
	$ cd ../..
	
## Run the tests

	$ ./bwread-tests.sh
	$ ./latencyread-tests.sh
	
## Generate the figures

	$ python3 gen-dat.py
	$ cd figures
	$ gnuplot gen.gp
	
The figures can then be found at figures/Fig6.pdf and figures/Fig7.pdf.
