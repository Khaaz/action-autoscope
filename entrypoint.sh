#!/bin/bash

set -eo pipefail

cd $GITHUB_WORKSPACE

SCOPE=`sed -e "s/\/.*//g" <<< $GITHUB_REPOSITORY`

cat package.json | sed -i -e 's/"name": "\([a-z0-9]*\)"/"name": "'$SCOPE'\/\1"/' package.json