#!/bin/bash

BIN=`dirname $BASH_SOURCE`

. $BIN/parse-args.sh
. $BIN/find-ci-version-path.sh

if [ "$GIT_COMMIT_AND_TAG_VERSION" == "YES" ]; then
    OLD_VER=`$BIN/semver.sh`
fi

if [ -z $1 ]; then
    echo '#define __CI_BUILD_META_DATA__' > $CI_VERSION_PATH/build-metadata.h
else
    value=`echo $1 | grep -oE '^[0-9a-zA-Z-]|[0-9a-zA-Z-][0-9a-zA-Z-]|([0-9a-zA-Z-]+(\.|[0-9a-zA-Z-])[0-9a-zA-Z-]+)$'`
    if [ "$1" != "$value" ]; then
        echo 'invalid build-metadata '$1
        exit 1
    fi
    echo '#define __CI_BUILD_META_DATA__ +'$1 > $CI_VERSION_PATH/build-metadata.h
fi

$BIN/date.sh
$BIN/git-commit.sh $OLD_VER