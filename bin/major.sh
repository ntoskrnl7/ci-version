#!/usr/bin/bash

bin=$(realpath `dirname $BASH_SOURCE`)

. $bin/find-ci-version-path.sh

if [ -z $1 ]; then
    major=$(sed 's/#define __CI_MAJOR_VERSION__//g' $CI_VERSION_PATH/major.h)
    major=$(expr $major + 1)
else
    major=$1
fi
echo '#define __CI_MAJOR_VERSION__ '$major > $CI_VERSION_PATH/major.h

$bin/minor.sh 0
$bin/patch.sh 0
$bin/date.sh