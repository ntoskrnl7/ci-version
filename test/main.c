#include <ci-version/semver.h>
#include <stdio.h>

int main() {
  puts(__CI_SEMVER__);
  return 0;
}