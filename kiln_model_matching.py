"""
==================
kiln_model_matching.py
==================

===============================================================================
A simple script for numerically integrating the time-dependent 1D heat equation
with convective+radiative boundary conditions. This is a very basic simulation 
of a kiln during the warmup process. This script also reads a .xls file with
temperature data and overlays the data with the predicted temperature vs. time traces.

This is part of the RepKiln project. More information about this code can be 
found here:

https://hackaday.io/project/21642-repkiln
 
Version 1.0 Initial Release - October 2017

Copyright 2017 Matt Moses   
mmoses152 at gmail dot com

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
===============================================================================
"""

import xlrd
import numpy as np
import matplotlib.pyplot as plt

# The first half of this code integrates the heat equation.
# The second part opens the .xls file with the experimental
# data and overlays it on the simulation results.

A = 0.34839 # cross sectional area of wall element in m^2
rho = 2000.0 # density of wall material in kg / m^3
k = 1.3 # thermal conductivity of wall material in W / (m*K)
c = 400.0 # specific heat capacity in J / (kg*K)
sigma = 5.6704E-08 # Stefan-Boltzmann constant in W * m^-2 * K^-4
h = 12.0 # convective heat transfer coefficient in W / (m^2 * K)

Q_dot_in = 1500.0 # heater power in watts

T_initial = 291.0 # initial temperature in Kelvin
T_inf = 291.0 # ambient temperature in Kelvin

L = 0.1143 # thickness of the entire wall in meters
N = 10 # number of discrete wall segments
dx = L/N # length of each wall segment in meters

total_time = 500*60 # total duration of simulation in seconds
nsteps = 2000 # number of timesteps
dt = total_time/nsteps # duration of timestep in seconds

# The size of this nondimensional factor gives a rough idea
# of the stability of the crude numerical integration we are using.
# If this is too big there will be problems.
simfac = (k*dt) / (c*rho*dx*dx)
print simfac

# this is the factor by which to multiply Q_dot_in and Q_dot_out
heatfac = dx / (k*A)

# initialize volume element coordinates and time samples
x = np.linspace(0, dx*(N-1), N)
timesamps = np.linspace(0, dt*nsteps, nsteps+1)

# create a 2D mesh grid for plotting
# a note on using meshgrid from 
# https://docs.scipy.org/doc/numpy/reference/generated/numpy.meshgrid.html
#
# "In the 2-D case with inputs of length M and N, the outputs are of 
# shape (N, M) for 'xy' indexing and (M, N) for 'ij' indexing."
X, TIME = np.meshgrid(x, timesamps, indexing='ij')

# initialize a big 2D array to store temperature values
T = np.zeros((X.shape))

# set the initial temperature profile of the wall
for i in range(len(x)):
   T[i, 0] = T_initial

# Debug stuff, uncomment if needed:
# print X.shape
# print timesamps
# print x
# print TIME
# print X
# print T

#T_out = T[len(x)-1, 0]
#Q_dot_out = sigma * A * (pow(T_out,4) - pow(T_inf,4)) + h * A * (T_out - T_inf)

#print Q_dot_in
#print Q_dot_out

for j in range(len(timesamps)-1):
   # get the outside wall temperature and heat flow at current time
   T_out = T[len(x)-1, j]
   Q_dot_out = sigma * A * (pow(T_out,4) - pow(T_inf,4)) + h * A * (T_out - T_inf)
   # now compute temperature at the outside boundary for the next time step
   T[len(x)-1, j+1] = T_out + simfac * (T[len(x)-2, j] - T_out - heatfac * Q_dot_out)
   # and now compute temperature at the inside boundary for the next time step
   T[0, j+1] = T[0,j] + simfac * (T[1,j] - T[0,j] + heatfac * Q_dot_in)
   # now loop through the interior elements to get their temp for the next time
   for i in range(len(x)-2):
      T[i+1,j+1] = T[i+1,j] + simfac * (T[i,j] - 2*T[i+1,j] + T[i+2,j])


fig1 = plt.figure()
line1, = plt.plot(timesamps/60,T[1,:], label="simulation, T inside")
line2, = plt.plot(timesamps/60,T[len(x)-1,:], label="simulation, T outside")
plt.xlabel('time (minutes)')
plt.ylabel('temperature (K)')
#plt.show()

# This part opens the .xls file and plots the relevant data
# IMPORTANT: the units of the .xls file are degrees fahrenheit
# and minutes

workbook = xlrd.open_workbook('repkiln-temperature-data.xls')
worksheet = workbook.sheet_by_index(0)

# get the minutes column from the spreadsheet
minutescol = worksheet.col_slice(colx=4,start_rowx=1)
minutes = []
for cell in minutescol:
   minutes.append(cell.value)

# get the T1 (inside kiln) column from the spreadsheet
T1col = worksheet.col_slice(colx=5, start_rowx=1)
T1 = []
for cell in T1col:
   T1.append(5.0/9.0*(cell.value-32.0)+273.0)

# get the T2 (outside kiln) column from the spreadsheet
T2col = worksheet.col_slice(colx=6, start_rowx=1)
T2 = []
for cell in T2col:
   T2.append(5.0/9.0*(cell.value-32.0)+273.0)

line3, = plt.plot(minutes,T1, 'b*', label="experiment, T inside")
line4, = plt.plot(minutes,T2, 'g.', label="eperiement, T outside")
plt.legend(handles=[line1, line2, line3, line4])

plt.legend(bbox_to_anchor=(.85, .75), bbox_transform=plt.gcf().transFigure)
plt.show()

# end of file
