#!/bin/bash

. ./functions

declare -a corunners=("BwRead" "LatencyRead" "BankRead" "BwWrite" "LatencyWrite" "BankWrite")
declare -a functions=(BwRead LatencyRead BankRead BwWrite LatencyWrite BankWrite)
declare -a benchmark=(bandwidth latency-mlp attacker3 bandwidth latency-mlp attacker3)

> latencyread-results.txt
index=0
for corun in "${functions[@]}"
do
	echo "${corunners[$count]}" >> latencyread-results.txt
	LatencyReadVictim 2> /dev/null | grep latency | awk 'NF { print $(NF-1) }' >> latencyread-results.txt
	for i in 1 2 3
	do
		$corun $i &> /dev/null &
		sleep 2
		LatencyReadVictim 2> /dev/null | grep latency | awk 'NF { print $(NF-1) }' >> latencyread-results.txt
	done
	killall "${benchmark[$count]}"
	count=$((count+1))
	echo "" >> latencyread-results.txt
done	
