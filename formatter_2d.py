import numpy as np
from matplotlib import pylab
import pandas

#fdir = './output/'

file_interval = 1
file_start = 1
file_end = 30+file_interval

dep=np.loadtxt('dep.out')

dx = 0.01
dy = 0.01
n,m = np.shape(dep)
normalDepth = 0.00798

x = np.zeros([n,m])
y = np.zeros([n,m])
for xa in range(m):
    for ya in range(n):
        x[ya, xa] = (xa+0.50)*dx
        y[ya, xa] = (ya+0.50)*dy
#x = np.asarray([float(xa)*dx for xa in range(m)])  
#y = np.asarray([float(ya)*dy for ya in range(n)])

output_series = np.arange(file_start, file_end, step=file_interval, dtype=int)

for i in output_series:
    if i>=10:
        filename_eta = "eta_000"+str(i)
        filename_u = "u_000"+str(i)
        filename_v = "v_000"+str(i)
        filename_mask = "mask_000"+str(i)
    elif i>=100:
        filename_eta = "eta_00"+str(i)
        filename_u = "u_00"+str(i)
        filename_v = "v_00"+str(i)
        filename_mask = "mask_00"+str(i)
    else:
        filename_eta = "eta_0000"+str(i)
        filename_u = "u_0000"+str(i)
        filename_v = "v_0000"+str(i)
        filename_mask = "mask_0000"+str(i)
    
    mask = np.loadtxt(filename_mask)
    eta = np.loadtxt(filename_eta)
    u = np.loadtxt(filename_u)
    v = np.loadtxt(filename_v)    
    depth = np.loadtxt('dep.out')
    #eta = eta+depth
    eta = eta+normalDepth
    eta_masked = np.ma.masked_where(mask==0,eta)  # do not plot where mask = 0
    x_masked = np.ma.masked_where(mask==0,x)
    y_masked = np.ma.masked_where(mask==0,y)
    u_masked = np.ma.masked_where(mask==0,u)
    v_masked = np.ma.masked_where(mask==0,v)


    profile_arr = np.vstack((x_masked.ravel(),y_masked.ravel(),eta_masked.ravel(),u_masked.ravel(),v_masked.ravel()))
    #profile_arr = np.vstack((x.ravel(),y.ravel(),eta_masked.ravel()))
    data_frame = pandas.DataFrame(profile_arr.T)
    # save all field variables
    data_frame.to_csv(str(i)+"_huv.txt", index=False, sep='\t')     
