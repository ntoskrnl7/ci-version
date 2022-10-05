#!/usr/bin/bash

bin=$(realpath `dirname $BASH_SOURCE`)

. $bin/find-ci-version-path.sh

if [ -z $1 ]; then
    patch=$(sed 's/#define __CI_PATCH_VERSION__//g' $CI_VERSION_PATH/patch.h)
    patch=$(expr $patch + 1)
else
    patch=$1
fi
echo '#define __CI_PATCH_VERSION__ '$patch > $CI_VERSION_PATH/patch.h

$bin/date.sh