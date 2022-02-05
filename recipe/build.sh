#!/bin/bash

export CFLAGS="-g -fPIC $CFLAGS $CPPFLAGS"
export CXXFLAGS="-g -fPIC $CXXFLAGS $CPPFLAGS"

# workaround for https://github.com/JohnCremona/eclib/issues/45
if [[ "${target_platform}" == "linux-"* ]]; then
    sed -i "s/long    rank(GEN x);//g" $PREFIX/include/pari/paridecl.h
fi

autoreconf -ivf
./configure --with-pari --prefix=${PREFIX}
make
make install INSTALL_DIR="$PREFIX"
