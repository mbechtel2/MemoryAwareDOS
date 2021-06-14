import numpy as np

bwread_llc_results = open("bwread-llc-results.txt", "r")
dat_vals = []
for i in range(6):
    dat_vals.append([])
    dat_vals[-1].append(bwread_llc_results.readline()[:-1])
    for j in range(4):
        if j == 0:
            solo = float(bwread_llc_results.readline())
            dat_vals[-1].append(1)
        else:
            temp = float(bwread_llc_results.readline())
            temp = temp / solo
            dat_vals[-1].append(temp)
    bwread_llc_results.readline()
bwread_llc_results.close()
np.savetxt("figures/Fig6.dat", dat_vals, delimiter="\t", fmt="%s")

bwread_dram_results = open("bwread-dram-results.txt", "r")
dat_vals = []
for i in range(6):
    dat_vals.append([])
    dat_vals[-1].append(bwread_dram_results.readline()[:-1])
    for j in range(4):
        if j == 0:
            solo = float(bwread_dram_results.readline())
            dat_vals[-1].append(1)
        else:
            temp = float(bwread_dram_results.readline())
            temp = np.around(temp / solo, decimals=2)
            dat_vals[-1].append(temp)
    bwread_dram_results.readline()
bwread_dram_results.close()
np.savetxt("figures/Fig7.dat", dat_vals, delimiter="\t", fmt="%s")