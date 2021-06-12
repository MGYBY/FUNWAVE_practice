#! /bin/bash
gfortran init_etauv.f -o a
gfortran obstacleRegion.f90 -o b
./a
./b
./funwave-VESSEL--gnu-parallel-single
