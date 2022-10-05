#ifndef __CI_STR__
#define __CI_STR__

#ifndef __CI_MACRO_VALUE_TO_STR__
#define __CI_MACRO_VALUE_TO_STR_2__(n) #n
#define __CI_MACRO_VALUE_TO_STR__(n) __CI_MACRO_VALUE_TO_STR_2__(n)
#endif

#include <ci-version/major.h>
#define __CI_MAJOR_VERSION_STR__ __CI_MACRO_VALUE_TO_STR__(__CI_MAJOR_VERSION__)

#include <ci-version/minor.h>
#define __CI_MINOR_VERSION_STR__ __CI_MACRO_VALUE_TO_STR__(__CI_MINOR_VERSION__)

#include <ci-version/patch.h>
#define __CI_PATCH_VERSION_STR__ __CI_MACRO_VALUE_TO_STR__(__CI_PATCH_VERSION__)

#include <ci-version/pre-release.h>
#define __CI_PRE_RELEASE_STR__ __CI_MACRO_VALUE_TO_STR__(__CI_PRE_RELEASE__)

#include <ci-version/build-metadata.h>
#define __CI_BUILD_META_DATA_STR__ __CI_MACRO_VALUE_TO_STR__(__CI_BUILD_META_DATA__)

#include <ci-version/date.h>
#define __CI_BUILD_DATE_STR__ __CI_MACRO_VALUE_TO_STR__(__CI_BUILD_DATE__)

#endif