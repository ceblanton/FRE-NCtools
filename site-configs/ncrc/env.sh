#!/bin/sh
#***********************************************************************
#                   GNU Lesser General Public License
#
# This file is part of the GFDL FRE NetCDF tools package (FRE-NCTools).
#
# FRE-NCTools is free software: you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# FRE-NCTools is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with FRE-NCTools (LICENSE.md).  If not, see
# <http://www.gnu.org/licenses/>.
#***********************************************************************
#
# Copyright (c) 2021 - Seth Underwood (@underwoo)
#
# This script configures the environment using Environment modules
# for building FRE-NCtools.  This script can be run with the `eval`
# command to modify the environment.  Syntax is similar to the
# syntax used in modulefiles.

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# DO NOT CHANGE THIS LINE
. $( dirname $( dirname $(readlink -f $0) ) )/env_functions.sh
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

module rm PrgEnv-pgi PrgEnv-intel PrgEnv-gnu PrgEnv-cray
module load PrgEnv-intel/6.0.5
module swap intel intel/18.0.6.288
module load cray-netcdf/4.6.3.2
module load cray-hdf5/1.10.5.2
module load nccmp/1.8.6.5
# Ocean model grid generator needs python3 with netCDF4 and numpy
# Needed here for tests but also needs to be available when running
module load PythonEnv-noaa/1.5.0

# Add bats to PATH
# Needed for testing
module append-path PATH /ncrc/home2/Seth.Underwood/opt/bats/0.4.0/bin

# **********************************************************************
# Set environment variablesSetup and Load the Modules
# **********************************************************************
setenv MPICH_UNEX_BUFFER_SIZE 256m
setenv MPICH_MAX_SHORT_MSG_SIZE 64000
setenv MPICH_PTL_UNEX_EVENTS 160k
setenv KMP_STACKSIZE 2g
setenv F_UFMTENDIAN big
setenv NC_BLKSZ 64K

# Set CONFIG_SITE to the correct config.site file for the system
setenv CONFIG_SITE $( dirname $(readlink -f $0) )/config.site

# Include the netcdf-c/netcdf-fortran library paths during linking
setenv LD_RUN_PATH \$LD_LIBRARY_PATH
