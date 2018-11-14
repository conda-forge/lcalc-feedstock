#!/bin/bash

export CFLAGS="-g -fPIC $CFLAGS $CPPFLAGS"
export CXXFLAGS="-g -fPIC $CXXFLAGS $CPPFLAGS"
export SAGE_LOCAL="$PREFIX"

cd src
make
make install INSTALL_DIR="$PREFIX"

# Delete unnecessary files
rm ${PREFIX}/include/libLfunction/*.crap
rm ${PREFIX}/include/libLfunction/*.bak
