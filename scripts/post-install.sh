#!/usr/bin/env bash

install_type="$(cat .bootstrap/TYPE)"

rm -rf .github/ && cp -rf .makesystem/${install_type:?}/github .github
cp .makesystem/common/github/workflows/* .github/workflows/

rm -rf .bootstrap/ && cp -rf .makesystem/bootstrap .bootstrap
echo "${install_type:?}" > .bootstrap/TYPE
