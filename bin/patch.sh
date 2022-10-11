#!/bin/bash

BIN=`dirname $BASH_SOURCE`

. $BIN/parse-args.sh
. $BIN/find-ci-version-path.sh

if [ -z "$1" ]; then
    patch=`sed 's/#define __CI_PATCH_VERSION__//g' $CI_VERSION_PATH/patch.h`
    patch=`expr $patch + 1`
else
    patch=$1
fi

if [ "$GIT_COMMIT_AND_TAG_VERSION" == "YES" ]; then
    OLD_VER=`$BIN/semver.sh`
fi

echo '#define __CI_PATCH_VERSION__ '$patch > $CI_VERSION_PATH/patch.h

$BIN/date.sh
$BIN/git-commit.sh $OLD_VER