#!/bin/bash

bin=$(realpath `dirname $BASH_SOURCE`)

. $bin/find-ci-version-path.sh

echo '#define __CI_BUILD_DATE__ '$(date '+%y%m%d') > $CI_VERSION_PATH/date.h