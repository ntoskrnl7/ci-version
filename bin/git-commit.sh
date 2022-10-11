#!/bin/bash

set -e

BIN=`dirname $BASH_SOURCE`

if [ "$GIT_COMMIT_AND_TAG_VERSION" == "YES" ]; then
    SEMVER=`$BIN/semver.sh`
    if [ "$1" != "$SEMVER" ]; then
        if [ -z "$GIT_COMMIT_MESSAGE" ]; then
            GIT_COMMIT_MESSAGE=$SEMVER
        else
            GIT_COMMIT_MESSAGE=`echo $GIT_COMMIT_MESSAGE  | sed 's/%s/'$SEMVER'/g'`
        fi
        git add .config > /dev/null 2>&1
        git commit -m "$GIT_COMMIT_MESSAGE" > /dev/null 2>&1
        git tag v$SEMVER
    fi
fi