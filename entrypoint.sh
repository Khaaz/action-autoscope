#!/bin/sh -l

set -eo pipefail

echo "Identify Github owner (scope)"
if [ -n "$SCOPE" ] && ! [ -z "$SCOPE" ]; then
    OWNER=$SCOPE
else
    OWNER=`sed -e "s/\/.*//g" <<< $GITHUB_REPOSITORY`
fi

echo "Scope the package in package.json"
cat package.json | sed -i -e 's/"name": "\([a-z0-9]*\)"/"name": "@'$OWNER'\/\1"/' package.json