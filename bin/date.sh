#!/bin/bash

BIN=`dirname $BASH_SOURCE`

. $BIN/find-ci-version-path.sh

echo '#define __CI_BUILD_DATE__ '`date '+%y%m%d'` > $CI_VERSION_PATH/date.h