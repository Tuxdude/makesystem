#!/usr/bin/env bash
set -E -e -o pipefail

script_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
repo_dir="$(realpath "${script_dir:?}/../../..")"

source ${repo_dir:?}/.makesystem/dockerfile/scripts/common
source ${repo_dir:?}/metadata/metadata

if [[ "$1" == "docker-flags" ]]; then
    dockerflags_output_build_args
else
    github_output_build_args
fi
