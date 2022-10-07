#!/bin/bash
set -ae

BIN=`dirname $BASH_SOURCE`

. $BIN/parse-args.sh

ROOT_PATH=.
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -r|--root-path)
            ROOT_PATH="$2"
            shift
            shift
        ;;
        -*|--*)
            echo "Unknown option $1"
            exit 1
        ;;
        *)
            POSITIONAL_ARGS+=("$1")
            shift
        ;;
    esac
done
set -- "${POSITIONAL_ARGS[@]}"

if [ -z `which realpath 2> /dev/null` ]; then
    function realpath() {
        local _X="$PWD"
        local _LNK=$1
        cd "$(dirname "$_LNK")"
        if [ -h "$_LNK" ]; then
            _LNK="$(readlink "$_LNK")"
            cd "$(dirname "$_LNK")"
        fi
        echo "$PWD/$(basename "$_LNK")"
        cd "$_X"
    }
fi

ROOT_PATH=`realpath $ROOT_PATH`
if [ ! -d "$ROOT_PATH" ]; then
    echo 'invalid directory : ' $ROOT_PATH
    exit 1
fi

export CI_VERSION_PATH=$ROOT_PATH/.config/ci-version
mkdir -p $CI_VERSION_PATH

if [ ! -f $CI_VERSION_PATH/major.h ]; then
    echo '' > $CI_VERSION_PATH/major.h
    $BIN/major.sh 0 --no-git-tag-version
    $BIN/pre-release.sh --no-git-tag-version
    $BIN/build-metadata.sh --no-git-tag-version
    $BIN/git-commit.sh
fi

if [ -z `which cygpath 2> /dev/null` ]; then
    function convpath() {
        echo $1
    }
else
    function convpath() {
        echo `cygpath -d -m $1`
    }
fi

echo 'function(ci_version target)
    target_include_directories(${target} PRIVATE "'$(convpath `realpath $BIN/../include`)'")
    target_include_directories(${target} PRIVATE "'$(convpath `realpath $CI_VERSION_PATH/..`)'")
endfunction()' > $ROOT_PATH/ci-version.cmake
