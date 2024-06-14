#!/usr/bin/env bash

set -E -e -o pipefail

script_parent_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
git_repo_dir="$(realpath "${script_parent_dir:?}/..")"

get_latest_tag() {
    git tag --list | sort --version-sort --reverse | head -1
}

get_next_semantic_ver() {
    echo "${1:?}" | awk -F. -v OFS=. '{$NF += 1 ; print}'
}

if [ -z "$1" ]; then
    # Generate the next semantic version number if version number is not supplied.
    rel_ver="$(get_next_semantic_ver $(get_latest_tag))"
else
    # Use the supplied version number from the command line arg.
    rel_ver="${1:?}"
fi

echo "Creating tag ${rel_ver:?}"
git githubtag -m "${rel_ver:?} release." ${rel_ver:?}
