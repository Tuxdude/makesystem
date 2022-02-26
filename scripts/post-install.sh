#!/usr/bin/env bash

install_type="$(cat .bootstrap/TYPE)"

rm -rf .github/ && cp -rf .makesystem/${install_type:?}/github .github

rm -rf .bootstrap/ && cp -rf .makesystem/bootstrap .bootstrap
echo "${install_type:?}" > .bootstrap/TYPE
