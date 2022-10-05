#!/usr/bin/bash

if [ ! -f "$CI_VERSION_PATH/major.h" ]; then
    CI_VERSION_PATH=`realpath ./.config/ci-version`
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

CI_VERSION_PATH=`realpath $CI_VERSION_PATH`