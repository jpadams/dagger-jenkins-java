#!/bin/bash

RUN="/usr/local/bin/dagger do -f ./queries.graphql"
CACHE=$($RUN Cache | jq -r '.cacheVolume.id')

JUNIT=$($RUN JUnitExample | jq -r '.git.branch.tree.directory.id')
GRADLE=$($RUN --set "workfs=$JUNIT" --set "cachevol=$CACHE" --set "cmd=test" Gradle | jq -r '.. | .contents? | select(. != null)')
echo $GRADLE 