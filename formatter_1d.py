import numpy as np
from matplotlib import pylab
import pandas

#fdir = './output/'

file_interval = 1
file_start = 0
file_end = 5+file_interval

dx = 0.01
m = 4200

x = np.asarray([float(xa-0.50)*dx for xa in range(m)])

output_series = np.arange(file_start, file_end, step=file_interval, dtype=int)

for i in output_series:
    if i>=10:
        filename = "eta_000"+str(i)
    elif i>=100:
        filename = "eta_00"+str(i)
    else:
        filename = "eta_0000"+str(i)

    eta = np.loadtxt(filename)
    depth = np.loadtxt('dep.out')
    depth = depth+eta
    
    depth = depth[0,:]
    profile_arr = np.vstack((x,depth))
    data_frame = pandas.DataFrame(profile_arr.T)
    # save only h for now
    data_frame.to_csv(str(i)+"_xyz.txt", index=False, sep='\t')     
