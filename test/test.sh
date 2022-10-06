#!/bin/bash

if [ -z `which realpath 2>/dev/null` ]; then
    function realpath() {
        local _X="$PWD"
        local _LNK=$1
        cd "$(dirname "$_LNK")"
        if [ -h "$_LNK" ]; then
            _LNK="$(readlink "$_LNK")"
            cd "$(dirname "$_LNK")"
        fi
        echo "$PWD/$(basename "$_LNK")"
        cd "$_X"
    }
fi

cd $(realpath `dirname $0`)

bin=$(realpath `dirname $BASH_SOURCE`/../bin)

rm -rf .config
$bin/init.sh
cmake -S . -B build -DCI_VERSION_PATH=`realpath .config` > /dev/null

ret=0
if [ -z `which nproc 2>/dev/null` ]; then
    function nproc() {
        echo `sysctl -n hw.physicalcpu`
    }
fi

function build_and_test() {
    cmake --build build --parallel `nproc` > /dev/null

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

$bin/release.sh
build_and_test

$bin/build-metadata.sh ci-version.test
build_and_test

$bin/pre-release.sh rc.2
build_and_test

$bin/patch.sh
build_and_test

$bin/build-metadata.sh 
$bin/major.sh
build_and_test

$bin/pre-release.sh rtm
$bin/minor.sh
build_and_test

$bin/major.sh
$bin/build-metadata.sh `date '+%y%m%d'`
$bin/release.sh
build_and_test

rm -rf .config

rm -rf build

exit $ret