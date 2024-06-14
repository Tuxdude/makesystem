#!/usr/bin/env bash
set -E -e -o pipefail

script_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
repo_dir="$(realpath "${script_dir:?}/../../..")"

source ${repo_dir:?}/.makesystem/dockerfile/scripts/common
source ${repo_dir:?}/metadata/metadata

if [ -z "$1" ]; then
    prepare_release
else
    prepare_release "${1:?}"
fi
