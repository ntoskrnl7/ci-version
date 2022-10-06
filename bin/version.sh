#!/bin/bash

bin=`dirname $BASH_SOURCE`

. $bin/find-ci-version-path.sh

mkdir -p $bin/version

echo '
#include <ci-version/version.h>
#include <stdio.h>

void main() {
    puts(__CI_VERSION__);
}
' > $bin/version/main.c

echo '
cmake_minimum_required(VERSION 3.13)

project(version C)

add_executable(version main.c)

target_include_directories(version PRIVATE ../../include)
target_include_directories(version PRIVATE ${CI_VERSION_PATH})
' > $bin/version/CMakeLists.txt

cmake -S $bin/version -B $bin/version/build -DCI_VERSION_PATH=$CI_VERSION_PATH/.. > /dev/null
cmake --build $bin/version/build  > /dev/null

if [ -f $bin/version/build/Debug/version.exe ]; then
    $bin/version/build/Debug/version.exe
    rm -rf $bin/version
    exit $?
fi

if [ -f $bin/version/build/version ]; then
    $bin/version/build/version
    rm -rf $bin/version
    exit $?
fi

rm -rf $bin/version

exit 1