#!/bin/bash
# Ryan Mulhall 2021
# Utility functions for FRE-NCtools bats test scripts
# setup and teardown run implicitly at beg and end of tests
# SETUP_FNCT must set to a function(or cmd) that creates the tests input files
# such as generate_from_ncl, otherwise no input will be created

testDir="$( basename $BATS_TEST_FILENAME .sh )"
testDir="`expr substr $testDir 1 6`"

setup(){
  BASE_TEST_DIR=$( pwd )
  TEST_NUM="`expr substr $(basename $BATS_TEST_FILENAME .sh) 5 2`"
  if [ ! -d $testDir ]; then
    mkdir $testDir
  fi
  cd $testDir
  # run the tests setup function, if set
  [[ ! -z $SETUP_FNCT ]] && $SETUP_FNCT || echo "Warning: SETUP_FNCT not set, skipping input generation"
}

teardown(){
  cd $BASE_TEST_DIR
  ls $testDir
  rm -rf $testDir
}

#generates numbered nc files with a given name
generate_all_from_ncl_num(){
  filename=$1
  for f in $top_srcdir/t/Test${TEST_NUM}-input/*.ncl.????
  do
    [[ -z $filename ]] && filename=$(basename $f .ncl)
    ncgen -o $filename.nc.${f##*.} $f
  done
}
#generates nc files from any ncl files in input directory
#takes a two digit test number, defaults to current test
generate_all_from_ncl(){
  if [[ -z $1 ]]; then 
    test_no=$TEST_NUM
  else
    test_no="$1"
  fi
  for f in $top_srcdir/t/Test${test_no}-input/*.ncl
  do
    filename=$(basename $f .ncl)
    ncgen -o $filename.nc $f
  done
}

#generates from a list of names, TODO might delete
generate_from_ncl(){
  if [[ $# == 0 || $1 != *.ncl ]]; then
    echo "Error: no/invalid filenames provided"
    exit
  else
    filename=$(basename $1 .ncl)
    ncgen -o $filename.nc $top_srcdir/t/$1
    [[ $# -eq 1 ]] && return 0
    shift
    generate_from_ncl $@
  fi
}
