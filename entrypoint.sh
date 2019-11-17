#!/bin/bash

set -eo pipefail

echo $SCOPE_ENV

echo "Identify Github owner (scope)"
SCOPE=`sed -e "s/\/.*//g" <<< $GITHUB_REPOSITORY`

echo "Scope the package in package.json"
cat package.json | sed -i -e 's/"name": "\([a-z0-9]*\)"/"name": "@'$SCOPE'\/\1"/' package.json