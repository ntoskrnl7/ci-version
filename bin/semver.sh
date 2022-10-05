#!/usr/bin/bash

bin=$(realpath `dirname $BASH_SOURCE`)

. $bin/find-ci-version-path.sh

echo '
#include <ci-version/semver.h>
#include <stdio.h>

void main() {
    puts(__CI_SEMVER__);
}
' > $bin/semver.c

gcc $bin/semver.c -o $bin/semver -I $CI_VERSION_PATH/.. -I $bin/../include
$bin/semver

rm $bin/semver
rm $bin/semver.c