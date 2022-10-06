#!/bin/bash

bin=$(realpath `dirname $BASH_SOURCE`)

. $bin/find-ci-version-path.sh

mkdir -p $bin/semver

echo '
#include <ci-version/semver.h>
#include <stdio.h>

void main() {
    puts(__CI_SEMVER__);
}
' > $bin/semver/main.c

echo '
cmake_minimum_required(VERSION 3.13)

project(semver C)

add_executable(semver main.c)

target_include_directories(semver PRIVATE ../../include)
target_include_directories(semver PRIVATE ${CI_VERSION_PATH})
' > $bin/semver/CMakeLists.txt

cmake -S $bin/semver -B $bin/semver/build -DCI_VERSION_PATH=$CI_VERSION_PATH/.. > /dev/null
cmake --build $bin/semver/build  > /dev/null

if [ -f $bin/semver/build/Debug/semver.exe ]; then
    $bin/semver/build/Debug/semver.exe
    rm -rf $bin/semver
    exit $?
fi

if [ -f $bin/semver/build/semver ]; then
    $bin/semver/build/semver
    rm -rf $bin/semver
    exit $?
fi

rm -rf $bin/semver

exit 1