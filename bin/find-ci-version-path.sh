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

if [ -z  $CI_VERSION_PATH ]; then
    CI_VERSION_PATH=.config/ci-version
fi

cur=`realpath $CI_VERSION_PATH`
while [ ! -f "$cur/major.h" ] && [  "$cur"  !=  "/" ]
do
    cur=`realpath $cur/..`
done

if [ ! -f "$cur/major.h" ]; then
    exit 1
fi

export CI_VERSION_PATH=$cur