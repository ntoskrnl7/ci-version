#!/bin/bash

if [ ! -f "$CI_VERSION_PATH/major.h" ]; then
    CI_VERSION_PATH=./.config/ci-version
    if [ ! -f "$CI_VERSION_PATH/major.h" ]; then
        CI_VERSION_PATH=../../.config/ci-version
        if [ ! -f "$CI_VERSION_PATH/major.h" ]; then
            CI_VERSION_PATH=
        fi
    fi
fi

if [ -z $CI_VERSION_PATH ]; then
    echo 'invalid CI_VERSION_PATH : ' $CI_VERSION_PATH
    exit 1
fi

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

CI_VERSION_PATH=`realpath $CI_VERSION_PATH`