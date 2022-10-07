#!/bin/bash

BIN=`dirname $BASH_SOURCE`

. $BIN/find-ci-version-path.sh

SEMVER_DIR=$BIN/semver_`date +%s%N`

mkdir -p $SEMVER_DIR

echo '
#include <ci-version/semver.h>
#include <stdio.h>

int main() {
    puts(__CI_SEMVER__);
    return 0;
}
' > $SEMVER_DIR/main.c

echo '
cmake_minimum_required(VERSION 3.13)

project(semver C)

add_executable(semver main.c)

target_include_directories(semver PRIVATE ../../include)
target_include_directories(semver PRIVATE ${CI_VERSION_PATH})
' > $SEMVER_DIR/CMakeLists.txt

cmake -S $SEMVER_DIR -B $SEMVER_DIR/build -DCI_VERSION_PATH=$CI_VERSION_PATH/.. > /dev/null 2>&1
cmake --build $SEMVER_DIR/build  > /dev/null 2>&1

if [ -f $SEMVER_DIR/build/Debug/semver.exe ]; then
    $SEMVER_DIR/build/Debug/semver.exe
    rm -rf $SEMVER_DIR
    exit $?
fi

if [ -f $SEMVER_DIR/build/semver ]; then
    $SEMVER_DIR/build/semver
    rm -rf $SEMVER_DIR
    exit $?
fi

rm -rf $SEMVER_DIR
exit 1