#!/bin/bash

export CFLAGS="-g -fPIC $CFLAGS $CPPFLAGS"
export CXXFLAGS="-g -fPIC $CXXFLAGS $CPPFLAGS"
export SAGE_LOCAL="$PREFIX"

# workaround for https://github.com/JohnCremona/eclib/issues/45
if [ "$(uname)" == "Linux" ]; then
    sed -i "s/long    rank(GEN x);//g" $PREFIX/include/pari/paridecl.h
fi

if [ "${c_compiler}" == "toolchain_c" ]; then
    export CXXFLAGS="-std=c++11 $CXXFLAGS"
fi

autoreconf -ivf
./configure --with-pari --prefix=${PREFIX}
make
make install INSTALL_DIR="$PREFIX"

# Delete unnecessary files
rm -f ${PREFIX}/include/Lfunction/*.crap
rm -f ${PREFIX}/include/Lfunction/*.bak

ln -s ${PREFIX}/include/Lfunction ${PREFIX}/include/libLfunction
