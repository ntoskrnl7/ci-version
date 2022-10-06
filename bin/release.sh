#!/bin/bash

bin=`dirname $BASH_SOURCE`

. $bin/find-ci-version-path.sh

echo '#define __CI_PRE_RELEASE__' > $CI_VERSION_PATH/pre-release.h

$bin/date.sh