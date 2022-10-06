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

if [ -z $1 ]; then
    root=`realpath .`
else
    root=`realpath $1`
fi

if [ ! -d "$root" ]; then
    echo 'invalid directory : ' $root
    exit 1
fi

export CI_VERSION_PATH=$root/.config/ci-version
mkdir -p $CI_VERSION_PATH

bin=$(realpath `dirname $0`)

if [ ! -f $CI_VERSION_PATH/major.h ]; then
    echo '' > $CI_VERSION_PATH/major.h
    $bin/major.sh 0
    $bin/build-metadata.sh
    $bin/pre-release.sh
fi

echo 'function(ci_version target)
    target_include_directories(${target} PRIVATE "'`realpath $bin/../include`'")
    target_include_directories(${target} PRIVATE "'`realpath $CI_VERSION_PATH/..`'")
endfunction()' > $root/ci-version.cmake
