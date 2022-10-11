#!/bin/bash

BIN=`dirname $BASH_SOURCE`

. $BIN/parse-args.sh
. $BIN/find-ci-version-path.sh

if [ "$GIT_COMMIT_AND_TAG_VERSION" == "YES" ]; then
    OLD_VER=`$BIN/semver.sh`
fi

if [ -z "$1" ]; then
    echo '#define __CI_PRE_RELEASE__ -alpha' > $CI_VERSION_PATH/pre-release.h
else
    value=`echo $1 | grep -oE '^[0-9a-zA-Z-]|[0-9a-zA-Z-][0-9a-zA-Z-]|([0-9a-zA-Z-]+(\.|[0-9a-zA-Z-])[0-9a-zA-Z-]+)$'`
    if [ "$1" != "$value" ]; then
        echo 'invalid pre-release '$1
        exit 1
    fi
    echo '#define __CI_PRE_RELEASE__ -'$1 > $CI_VERSION_PATH/pre-release.h
fi

$BIN/date.sh
$BIN/git-commit.sh $OLD_VER