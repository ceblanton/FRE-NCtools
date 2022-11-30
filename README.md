# FRE-NCtools

FRE-NCtools is a collection of tools for creating grids and mosaics
commonly used in climate and weather models, the remapping of data among grids,
and the creation and manipulation of netCDF files.
These tools were largely written by members of the GFDL
[Modeling Systems Group](https://www.gfdl.noaa.gov/modeling-systems)
primarily for use in the
[Flexible Modeling System](https://www.gfdl.noaa.gov/fms) (FMS)
[Runtime Environment](https://www.gfdl.noaa.gov/fre) (FRE) supporting the
work of the 
[Geophysical Fluid Dynamics Laboratory](https://www.gfdl.noaa.gov)
(GFDL).

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

### Statistical and Informational Tools

* list_ncvars -- List the variables in a netCDF file
* plevel -- Interpolates data from model levels to pressure levels
* split_ncvars -- Write the variables in a FMS netCDF file into multiple netCDF files, one file per netCDf field
* timavg -- Create a time average netCDF file
* ncexists -- Checks for variables and attributes in a netCDF file
* nc_null_check -- Checks to see if the value of the attribute *bounds* of variable *lat* has a null character


### Other Tools
The [Ocean Model Grid Generator](https://github.com/NOAA-GFDL/ocean_model_grid_generator)
is a collection of tools for creating finite element spherical tripolar grids for
GFDL's MOM based ocean models. Unlike the other tools, NCTools includes it as a submodule,
and also it is a Python3 project. Because of the former attribute, recursive
cloning (see below) is recommended. Because of the latter attribute,
the users python environment may need modification and/or options to the
autotools configure command may need to be specified. This includes the
``--disable-ocean-model-grid-generator`` option (default is enable)
and the ```--enable-venv``` option to build a Python venv containing the
Ocean Model Grid Generator script and all python dependencies.

### User Documentation
Documentation on using individual tools may be obtained by running
the tool without arguments or with the `-h` or `--help` options. Generally
this provides a list of the legal command line arguments, and frequently with
examples and explanations.

Many of the tools are commonly used in conjunction with other tools or as part of a
workflow. The directory FRE-NCtools/t has numerous test scripts that exercise
some possible workflows. As an example, consider the script for CI test #3
(file Test03-grid_coupled_model.sh) for creating grids and mosaics for a coupled model.
As a second example, script Test20-fregrid.sh creates a target mosaic
(file latlon_grid.nc) and then uses fregrid to remap an existing file
(--input_file ocean_temp_salt.res.nc) of a known mosaic (CM2.1_mosaic.nc)
to the target mosaic.

Additional documentation may be found in the documentation directory
( FRE-NCtools/docs ) and the
[FRE-NCTools wiki](https://github.com/NOAA-GFDL/FRE-NCtools/wiki/)


## Contributing to NCTools

The NCTools project encourages contributions from external parties.
This includes bug fixes and enhancements of existing code; even
entire external projects can be contributed as submodules.
Contribution requirements include :
 * The passing of existing unit tests when they are run in the CI system.
 * The (potential) addition of unit tests when adding new functionality.
 * For external projects, unit tests may be required and the unit tests
   should be run on the external CI system. 

 Additionally, since NCTools is distributable via the Spack package manager,
 the NCTools team will need to be able to compile and distribute via Spack any
 submodules and their dependencies. Contributors are encouraged to provide
 Spack recipes for their projects.

## Cloning and submodules
The NCTools github repository contains Ocean Model Grid Generator's repository
as a submodule. After cloning NCTools, it must be initialized and updated for
its submodules:

```
git clone --recursive https://github.com/NOAA-GFDL/FRE-NCtools
cd FRE-NCtools
git submodule update --init --recursive
```

## Building and Installation - General Information
FRE-NCtools has a collection of C and Fortran sources. Within GFDL, FRE-NCtools
is built using a recent version of the GNU and Intel C and Fortran compilers.
Compiler flags required for compilation are commonly set in
environment variables and the important ones include :

*  CC          (The C compiler command)
*  FC          (The Fortran compiler command)
*  CFLAGS      (The C compiler flags)
*  FCFLAGS     (The Fortran compiler flags)
*  LDFLAGS     (The linker flags, e.g. -L<lib dir> if you have libraries in a
              nonstandard directory <lib dir>)

On many systems, information of the NetCDF headers and libraries
can be obtained by the nf-config and nc-config commands.

## Building and Installation - Possible minimum configuration

If you received this as a package, the standard:

```
cd FRE-NCtools
configure
make
make install
```

should be sufficient.  If you cloned the git repository, you must first run
the `autoreconf` command with the `-i` (or `--install`) option to install
missing autotools files:

```
cd FRE-NCtools
autoreconf -i
./configure
make
make install
```

## Building and Installation - Common options
The legal options to the `make` and the `configure` commands can be listed by the commands:
```
make --help
configure --help=recursive
```

It is common to compile into a build directory (e.g. named `build`) and
install into an installation directory (e.g. with full path `<install path>`).
If the ocean_model_grid_generator is desired, it may be convenient to allow
the build system to set up a Python venv. These three choices can be
done with these steps:
```
cd FRE-NCtools
autoreconf -i
mkdir build && cd build
../configure --prefix=<install path> --enable-venv
make
make install
```

If the ocean_model_grid_generator is not desired, a similar configuration would
be achieved by :

```
cd FRE-NCtools
autoreconf -i
mkdir build && cd build
../configure --prefix=<install path> --disable-ocean-model-grid-generator
make
make install
```

### Parallel NCTools applications
The option  `--with-mpi` to the `configure` command will configure for building
parallel running versions of certain FRE-NCtools applications.


## Building on a GFDL-managed system
The recommended environment with the recommended autoconf defaults can be loaded by running
the output generated by the site-specific `env.sh` script. The script are run before running
the autoreconf command, and  they are located in the [site-configs](site-configs) directory.
For example:

```
# Note: env.sh builds a set of commands to configure the environment.
# The backquotes (not single quotes!) do command substitution, using the
# standard output of env.sh as input to "eval". eval then executes the
# set of environment-setting shell commands.
eval `site-configs/<site>/env.sh`
```


## Compiler Requirements.

A compiler with support for the C99 standard is required since NCTools release 18.1.
Compile time errors may be generated by compilers that do not support this standard,
and upgrading to a sufficiently recent compiler version is recommended in this case.
NCTools has been built and tested with GCC and Intel compilers.


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
