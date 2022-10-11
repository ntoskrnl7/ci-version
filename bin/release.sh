#!/bin/bash

BIN=`dirname $BASH_SOURCE`

. $BIN/parse-args.sh
. $BIN/find-ci-version-path.sh

if [ "$GIT_COMMIT_AND_TAG_VERSION" == "YES" ]; then
    OLD_VER=`$BIN/semver.sh`
fi

echo '#define __CI_PRE_RELEASE__' > $CI_VERSION_PATH/pre-release.h

$BIN/date.sh
$BIN/git-commit.sh $OLD_VER