#!/bin/bash

cd $(realpath `dirname $0`)

bin=$(realpath `dirname $BASH_SOURCE`/../bin)

rm -rf .config
$bin/init.sh
cmake -S . -B build -DCI_VERSION_PATH=`realpath .config` > /dev/null

ret=0
function build_and_test() {
    cmake --build build --parallel $(nproc) > /dev/null

    if [ -f ./build/test ]; then
        res=`./build/test`
    elif [ -f ./build/Debug/test ]; then
        res=`./build/Debug/test`
    fi

    res2=`$bin/semver.sh`
    
    if [ "$res" == "$res2"  ]; then
        echo [OK]$res == $res2
    else
        echo  [FAILED] $res != $res2
        ret=`expr $ret + 1`
    fi
}

build_and_test

$bin/major.sh 2
build_and_test

$bin/build-metadata.sh
$bin/release.sh
build_and_test

$bin/pre-release.sh rc.2
build_and_test

$bin/patch.sh
build_and_test

$bin/major.sh
build_and_test

$bin/minor.sh
build_and_test

$bin/release.sh
build_and_test

rm -rf .config

rm -rf build

exit $ret