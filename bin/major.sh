#!/bin/bash

BIN=`dirname $BASH_SOURCE`

. $BIN/parse-args.sh
. $BIN/find-ci-version-path.sh

if [ -z "$1" ]; then
    major=`sed 's/#define __CI_MAJOR_VERSION__//g' $CI_VERSION_PATH/major.h`
    major=`expr $major + 1`
else
    major=$1
fi

if [ "$GIT_COMMIT_AND_TAG_VERSION" == "YES" ]; then
    OLD_VER=`$BIN/semver.sh`
fi

echo '#define __CI_MAJOR_VERSION__ '$major > $CI_VERSION_PATH/major.h

$BIN/minor.sh 0 --no-git-tag-version
$BIN/git-commit.sh $OLD_VER