#!/usr/bin/bash

bin=$(realpath `dirname $BASH_SOURCE`)
. $bin/find-ci-version-path.sh

echo '
#include <ci-version/version.h>
#include <stdio.h>

void main() {
    puts(__CI_VERSION__);
}
' > $bin/version.c

gcc $bin/version.c -o $bin/version -I $CI_VERSION_PATH/.. -I $bin/../include
$bin/version

rm $bin/version
rm $bin/version.c