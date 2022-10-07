#!/bin/bash

BIN=`dirname $BASH_SOURCE`

. $BIN/parse-args.sh
. $BIN/find-ci-version-path.sh

if [ -z "$1" ]; then
    minor=`sed 's/#define __CI_MINOR_VERSION__//g' $CI_VERSION_PATH/minor.h`
    minor=`expr $minor + 1`
else
    minor=$1
fi

if [ "$GIT_COMMIT_AND_TAG_VERSION" == "YES" ]; then
    OLD_VER=`$BIN/semver.sh`
fi

echo '#define __CI_MINOR_VERSION__ '$minor > $CI_VERSION_PATH/minor.h

$BIN/patch.sh 0 --no-git-tag-version
$BIN/git-commit.sh $OLD_VER