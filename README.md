# ci-version

- [ci-version](#ci-version)
  - [Requirements](#requirements)
  - [Usage](#usage)
    - [Macros](#macros)
      - [Examples](#examples)
  - [Test](#test)

## Requirements

- Linux
- macOS
- Windows
- bash
  - Git, MSYS2, MINGW
- CMake 3.13+

## Usage

```bash
cd {project}

git submodule add http://github.com/ntoskrnl7/ci-version
./ci-version/bin/init.sh

cd ./ci-version/bin

# show version
./version.sh
# 0.0.0

./patch.sh
# 0.0.1

./patch.sh 4
# 0.0.4

./minor.sh
# 0.1.0
./minor.sh 4
# 0.4.0

./major.sh
# 1.0.0

./major.sh 4
# 4.0.0

# show version
./version.sh

./pre-release.sh
# 4.0.0-alpha

./pre-release.sh beta
# 4.0.0-beta

./build-metadata.sh test
# 4.0.0-beta+test

# show version
./semver.sh
# 4.0.0-beta+test

# show version
./version.sh
# 4.0.0

./build-metadata.sh
# 4.0.0-beta

./release.sh
# 4.0.0
```

### Macros

| Name                         | Value  (0.1.2-beta+test) |
| ---------------------------- | ------------------------ |
| `__CI_MAJOR_VERSION__`       | 0                        |
| `__CI_MAJOR_VERSION_STR__`   | "0"                      |
| `__CI_MINOR_VERSION__`       | 1                        |
| `__CI_MINOR_VERSION_STR__`   | "1"                      |
| `__CI_PATCH_VERSION__`       | 2                        |
| `__CI_PATCH_VERSION_STR__`   | "2"                      |
| `__CI_PRE_RELEASE__`         | beta                     |
| `__CI_PRE_RELEASE_STR__`     | "beta"                   |
| `__CI_BUILD_META_DATA__`     | test                     |
| `__CI_BUILD_META_DATA_STR__` | "test"                   |
| `__CI_BUILD_DATE__`          | 220202                   |
| `__CI_BUILD_DATE_STR__`      | "220202"                 |
| `__CI_VERSION__`             | "0.1.2"                  |
| `__CI_SEMVER__`              | "0.1.2-beta+test"        |
| `__CI_SEMANTIC_VERSION__`    | "0.1.2-beta+test"        |

#### Examples

```C
#include <ci-version/version.h>
#include <ci-version/semver.h>
#include <stdio.h>

puts(__CI_VERSION__);
puts(__CI_SEMVER__);
```

## Test

```bash
cd test
./test.sh
````
