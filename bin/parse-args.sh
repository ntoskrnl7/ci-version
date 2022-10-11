#!/bin/bash

export GIT_COMMIT_MESSAGE=
export GIT_COMMIT_AND_TAG_VERSION=YES
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -m|--message)
            GIT_COMMIT_MESSAGE="$2"
            shift
            shift
        ;;
        --no-git-tag-version)
            GIT_COMMIT_AND_TAG_VERSION=NO
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