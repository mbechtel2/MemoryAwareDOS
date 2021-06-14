#!/bin/bash

. ./functions

declare -a corunners=("BwRead" "PLLRead" "BkPLLRead" "BwWrite" "PLLWrite" "BkPLLWrite")
declare -a functions=(BwRead PLLRead BkPLLRead BwWrite PLLWrite BkPLLWrite)
declare -a benchmark=(bandwidth latency-mlp attacker3 bandwidth latency-mlp attacker3)

# BwRead (LLC) tests
> bwread-llc-results.txt
count=0
for corun in "${functions[@]}"
do
	echo "${corunners[$count]}" >> bwread-llc-results.txt
	BwReadVictim 48 2> /dev/null | grep average | awk 'NF { print $(NF-1) }' >> bwread-llc-results.txt
	for i in 1 2 3
	do
		$corun $i &> /dev/null &
		BwReadVictim 48 2> /dev/null | grep average | awk 'NF { print $(NF-1) }' >> bwread-llc-results.txt
	done
	killall "${benchmark[$count]}"
	count=$((count+1))
	echo "" >> bwread-llc-results.txt
done

# BwRead (DRAM) tests
> bwread-dram-results.txt
count=0
for corun in "${functions[@]}"
do
	echo "${corunners[$count]}" >> bwread-dram-results.txt
	BwReadVictim 16384 2> /dev/null | grep average | awk 'NF { print $(NF-1) }' >> bwread-dram-results.txt
	for i in 1 2 3
	do
		$corun $i &> /dev/null &
		BwReadVictim 16384 2> /dev/null | grep average | awk 'NF { print $(NF-1) }' >> bwread-dram-results.txt
	done
	killall "${benchmark[$count]}"
	count=$((count+1))
	echo "" >> bwread-dram-results.txt
done
