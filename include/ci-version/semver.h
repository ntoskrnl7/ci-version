#ifndef __CI_SEMANTIC_VERSION__

#include "str.h"

#define __CI_SEMANTIC_VERSION__                                                \
  __CI_MAJOR_VERSION_STR__ "." __CI_MINOR_VERSION_STR__                        \
                           "." __CI_PATCH_VERSION_STR__ __CI_PRE_RELEASE_STR__ \
                               __CI_BUILD_META_DATA_STR__

#define __CI_SEMVER__ __CI_SEMANTIC_VERSION__

#endif // __CI_SEMANTIC_VERSION__
