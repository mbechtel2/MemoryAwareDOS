import numpy as np

bwread_results = open("bwread-results.txt", "r")
dat_vals = []
for i in range(6):
    dat_vals.append([])
    dat_vals[-1].append(bwread_results.readline()[:-1])
    for j in range(4):
        if j == 0:
            solo = float(bwread_results.readline())
            dat_vals[-1].append(1)
        else:
            temp = float(bwread_results.readline())
            temp = temp / solo
            dat_vals[-1].append(temp)
    bwread_results.readline()
bwread_results.close()
np.savetxt("figures/Fig6.dat", dat_vals, delimiter="\t", fmt="%s")

latencyread_results = open("latencyread-results.txt", "r")
dat_vals = []
for i in range(6):
    dat_vals.append([])
    dat_vals[-1].append(latencyread_results.readline()[:-1])
    for j in range(4):
        if j == 0:
            solo = float(latencyread_results.readline())
            dat_vals[-1].append(1)
        else:
            temp = float(latencyread_results.readline())
            temp = np.around(temp / solo, decimals=2)
            dat_vals[-1].append(temp)
    latencyread_results.readline()
latencyread_results.close()
np.savetxt("figures/Fig7.dat", dat_vals, delimiter="\t", fmt="%s")