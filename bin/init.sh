#!/usr/bin/bash

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

echo '' > $CI_VERSION_PATH/major.h
$bin/major.sh 0
$bin/build-metadata.sh
$bin/pre-release.sh