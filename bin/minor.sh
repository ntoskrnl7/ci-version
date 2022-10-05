#!/usr/bin/bash

bin=$(realpath `dirname $BASH_SOURCE`)

. $bin/find-ci-version-path.sh

if [ -z $1 ]; then
    minor=$(sed 's/#define __CI_MINOR_VERSION__//g' $CI_VERSION_PATH/minor.h)
    minor=$(expr $minor + 1)
else
    minor=$1
fi
echo '#define __CI_MINOR_VERSION__ '$minor > $CI_VERSION_PATH/minor.h

$bin/patch.sh 0
$bin/date.sh