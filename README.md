# FRE-NCtools

FRE-NCtools is a collection of tools to help with the creation and
manipulation of netCDF files used or written by the climate
models developed at the
[Geophysical Fluid Dynamics Laboratory](https://www.gfdl.noaa.gov)
(GFDL).  These tools were primarily written by members of the GFDL
[Modeling Systems Group](https://www.gfdl.noaa.gov/modeling-systems)
to be used in the
[Flexible Modeling System](https://www.gfdl.noaa.gov/fms) (FMS)
[Runtime Environment](https://www.gfdl.noaa.gov/fre) (FRE).

[![Actions](https://github.com/NOAA-GFDL/FRE-NCtools/workflows/FRE-NCtools%20CI/badge.svg)](https://github.com/NOAA-GFDL/FRE-NCtools/actions) 
[![License: LGPL v3](https://img.shields.io/badge/License-LGPL%20v3-blue.svg)](https://www.gnu.org/licenses/lgpl-3.0)

## Tools

The tools available in FRE-NCtools are:

### Combine Tools

* combine_restarts -- Combine restart files generated by a FMS enabled model
* iceberg_comb -- Combine iceberg history files
* combine-ncc -- Combine distributed unstructured FMS grid netCDF files
* decompress-ncc -- Convert an unstructured FMS grid file to a standard lat-lon grid
* mppnccombine -- Combine destributed FMS netCDF files
* is-compressed -- Determine if a netCDF file has an unstructured FMS grid
* scatter-ncc -- Distribute an unstructured FMS grid netCDF file for initializing a FMS climate model
* mppncscatter -- Distribute FMS netCDF file for initializing a FMS climate model

### Statistical and Informational Tools

* list_ncvars -- List the variables in a netCDF file
* plevel -- Interpolates data from model levels to pressure levels
* split_ncvars -- Write the variables in a FMS netCDF file into multiple netCDF files, one file per netCDf field
* timavg -- Create a time average netCDF file
* ncexists -- Checks for variables and attributes in a netCDF file
* nc_null_check -- Checks to see if the value of the attribute *bounds* of variable *lat* has a null character

### Grid Tools
* check_mask -- Configure the processors which contains all land points to be masked out for ocean model
* fregrid -- Convert from one grid resolution to another
* make_coupler_mosaic -- Generates three exchange grids for the FMS coupler
* make_hgrid -- Generate different types of horizontal grids
* make_land_domain -- Generate a land domain file
* make_quick_mosaic -- Generate a complete grid file for the FMS coupler
* make_regional_mosaic -- Generate horizontal grid and solo mosaic to regrid regional output onto a regular lat-lon grid
* make_solo_mosaic -- Generates Mosaic information between tiles
* make_topog -- Generate the topography for any Mosaic
* make_vgrid -- Generate a vertical grid for a FMS model
* remap_land -- Remap land restart file from one mosaic grid to another mosaic grid
* river_regrid -- Remap river network data from global regular lat-lon grid onto any other grid
* runoff_regrid -- Regrid land runoff data to the nearest ocean point
* transfer_to_mosaic_grid -- Convert older style grids to newer mosaic grid

## Install

FRE-NCtools has a collection of C and Fortran sources.  Within GFDL, FRE-NCtools
is built using a recent version of the Intel C and Fortran compilers.  Using
other compilers (GCC/GFortran) is possible, but is not tested by the Modeling
Systems group at GFDL.

FRE-NCtools is built using the GNU Build System.  If you received this as a
package, the standard:

```
configure
make
make install
```

should be sufficient.  If you cloned the git repository, you must first run
the `autoreconf` command with the `--install` option to copy in the missing
autoconf files:

```
autoreconf -i
./configure
make
make install
```

Additionally, you will probably need to set the environment variable CONFIG_SITE
and set the recommended environment (modules):

```
export CONFIG_SITE=/path/to/package/site-configs/<site>/config.site
source /path/to/package/site-configs/<site>/env.sh
```

The above steps may need to be augmented depending upon your user evironment setup.
For example, if autoreconfig is in /home/MyUsername/FRE-NCtools, it will create the
configure command in this directory. You may tell the bash shell, for example,
the location of both by this command:

```
export PATH=/home/MyUsername/FRE-NCtools:$PATH
```

Additionally, installing into a non-default directory may be desired or neccesary.
For example, if the target directory is /home/MyUsername/bin, then FRE-NCtools
building is configured by:

```
autoreconf -i
./configure --prefix=/home/MyUsername/bin
```

Finally compile and install the tools as usual:

```
make
make install
```

Some FRE-NCtools applications can be run in parallel using MPI.  If the
`--with-mpi` option is given to `configure`, the MPI version of those
applications will be built.

A few site configurations, for GFDL managed systems, are available in the
[site-config](site-config) directory.  These can be used by setting the
`CONFIG_SITE` environment variable prior to running `configure`.

## Documentation

An embarrassingly small number of the commands have man pages.  These man pages
are written using [AsciiDoc](http://asciidoc.org/) format.  If AsciiDoc is found
on the system, the man pages will be built and installed automatically.

Most commands support either a `-h` or `--help` options.  In some cases, this
should be enough to get you started using the commands.  We are in the process
of collecting more information on the tools available in this package.  These
will be added when available.

Commonly, to combine restart and history files, one should run is-compressed on
the candidate file first.

If it returns 0, it's land compressed file that needs:
1. combine-ncc inputfile1 inputfile2 outputfile
2. decompress-ncc inputfile outputfile

If is-compressed returns non-zero, it's a regular distributed file that gets:
1. mppnccombine outputfile inputfile1 inputfile2 ...


## Disclaimer

The United States Department of Commerce (DOC) GitHub project code is provided
on an 'as is' basis and the user assumes responsibility for its use.  The DOC has
relinquished control of the information and no longer has responsibility to
protect the integrity, confidentiality, or availability of the information.  Any
claims against the Department of Commerce stemming from the use of its GitHub
project will be governed by all applicable Federal law. Any reference to
specific commercial products, processes, or services by service mark,
trademark, manufacturer, or otherwise, does not constitute or imply their
endorsement, recommendation or favoring by the Department of Commerce.  The
Department of Commerce seal and logo, or the seal and logo of a DOC bureau,
shall not be used in any manner to imply endorsement of any commercial product
or activity by DOC or the United States Government.

This project code is made available through GitHub but is managed by NOAA-GFDL
at https://www.gfdl.noaa.gov.
