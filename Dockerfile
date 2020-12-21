FROM ubuntu:16.04

RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:remik-ziemlinski/nccmp --update
RUN apt-get install -y libnetcdf-dev libnetcdff-dev netcdf-bin gfortran autoconf git csh tcsh
RUN git clone http://github.com/NOAA-GFDL/FRE-NCtools.git /src && mkdir /build && cd /build
RUN autoreconf -i /src/configure.ac && /src/./configure && make && make install && rm -rf /src
