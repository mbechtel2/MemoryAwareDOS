#!/bin/bash

. ./functions

declare -a corunners=("BwRead" "LatencyRead" "BankRead" "BwWrite" "LatencyWrite" "BankWrite")
declare -a functions=(BwRead LatencyRead BankRead BwWrite LatencyWrite BankWrite)
declare -a benchmark=(bandwidth latency-mlp attacker3 bandwidth latency-mlp attacker3)

> bwread-results.txt
index=0
for corun in "${functions[@]}"
do
	echo "${corunners[$count]}" >> bwread-results.txt
	BwReadVictim 2> /dev/null | grep average | awk 'NF { print $(NF-1) }' >> bwread-results.txt
	for i in 1 2 3
	do
		$corun $i &> /dev/null &
		BwReadVictim 2> /dev/null | grep average | awk 'NF { print $(NF-1) }' >> bwread-results.txt
	done
	killall "${benchmark[$count]}"
	count=$((count+1))
	echo "" >> bwread-results.txt
done
