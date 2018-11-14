#!/bin/bash

export CFLAGS="-g -fPIC $CFLAGS $CPPFLAGS"
export CXXFLAGS="-g -fPIC $CXXFLAGS $CPPFLAGS"
export SAGE_LOCAL="$PREFIX"

# workaround for https://github.com/JohnCremona/eclib/issues/45
if [ "$(uname)" == "Linux" ]; then
    sed -i "s/long    rank(GEN x);//g" $PREFIX/include/pari/paridecl.h
fi

cd src
make
make install INSTALL_DIR="$PREFIX"

# Delete unnecessary files
rm ${PREFIX}/include/libLfunction/*.crap
rm ${PREFIX}/include/libLfunction/*.bak
