#!/bin/bash

BIN=`dirname $BASH_SOURCE`

. $BIN/find-ci-version-path.sh

VERSION_DIR=$BIN/version_`date +%s%N`

mkdir -p $VERSION_DIR

echo '
#include <ci-version/version.h>
#include <stdio.h>

int main() {
    puts(__CI_VERSION__);
    return 0;
}
' > $VERSION_DIR/main.c

echo '
cmake_minimum_required(VERSION 3.13)

project(version C)

add_executable(version main.c)

target_include_directories(version PRIVATE ../../include)
target_include_directories(version PRIVATE ${CI_VERSION_PATH})
' > $VERSION_DIR/CMakeLists.txt

cmake -S $VERSION_DIR -B $VERSION_DIR/build -DCI_VERSION_PATH=$CI_VERSION_PATH/.. > /dev/null 2>&1
cmake --build $VERSION_DIR/build  > /dev/null 2>&1

if [ -f $VERSION_DIR/build/Debug/version.exe ]; then
    $VERSION_DIR/build/Debug/version.exe
    rm -rf $VERSION_DIR
    exit $?
fi

if [ -f $VERSION_DIR/build/version ]; then
    $VERSION_DIR/build/version
    rm -rf $VERSION_DIR
    exit $?
fi

rm -rf $VERSION_DIR
exit 1