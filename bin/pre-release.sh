#!/bin/bash

bin=`dirname $BASH_SOURCE`

. $bin/find-ci-version-path.sh

if [ -z $1 ]; then
    echo '#define __CI_PRE_RELEASE__ -alpha' > $CI_VERSION_PATH/pre-release.h
else
    value=`echo $1 | grep -oE '^[0-9a-zA-Z-]|([0-9a-zA-Z-]+(\.|[0-9a-zA-Z-])[0-9a-zA-Z-]+)$'`
    if [ "$1" != "$value" ]; then
        echo 'invalid pre-release '$1
        exit 1
    fi
    echo '#define __CI_PRE_RELEASE__ -'$1 > $CI_VERSION_PATH/pre-release.h
fi

$bin/date.sh