#! /bin/sh

#-----------------------------------------------------------------------------
#
# Build the linux 32 bit version.
#
rm -rf build_linux32
mkdir build_linux32
cd build_linux32

cmake -DCMAKE_C_FLAGS=-m32 -DCMAKE_CXX_FLAGS=-m32 -DTARGET_PROCESSOR=i686 ..
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

make
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

make test
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

make package
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

cd ..


#-----------------------------------------------------------------------------
#
# Build the linux 64 bit version.
#
rm -rf build_linux64
mkdir build_linux64
cd build_linux64

cmake -DCMAKE_C_FLAGS=-m64 -DCMAKE_CXX_FLAGS=-m64 -DTARGET_PROCESSOR=x86_64 ..
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

make
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

make test
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

make package
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

cd ..


#-----------------------------------------------------------------------------
#
# Build the windows 32 bit version.
#
rm -rf build_windows32
mkdir build_windows32
cd build_windows32

cmake -DCMAKE_C_FLAGS=-m32 -DCMAKE_CXX_FLAGS=-m32 -DCMAKE_SYSTEM_NAME=Windows -DTARGET_PROCESSOR=x86 -DCMAKE_C_COMPILER=/usr/bin/i686-w64-mingw32-gcc -DCMAKE_CXX_COMPILER=/usr/bin/i686-w64-mingw32-g++ -DCMAKE_RC_COMPILER=/usr/bin/i686-w64-mingw32-windres ..
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

make
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

make test
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

make package
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

cd ..


#-----------------------------------------------------------------------------
#
# Build the windows 64 bit version.
#
rm -rf build_windows64
mkdir build_windows64
cd build_windows64

cmake -DCMAKE_C_FLAGS=-m64 -DCMAKE_CXX_FLAGS=-m64 -DCMAKE_SYSTEM_NAME=Windows -DTARGET_PROCESSOR=amd64 -DCMAKE_C_COMPILER=/usr/bin/x86_64-w64-mingw32-gcc -DCMAKE_CXX_COMPILER=/usr/bin/x86_64-w64-mingw32-g++ -DCMAKE_RC_COMPILER=/usr/bin/x86_64-w64-mingw32-windres ..
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

make
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

make test
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

make package
STATUS=$?
if [ $STATUS -ne 0 ]; then
	exit 1
fi

cd ..

