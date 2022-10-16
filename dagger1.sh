#!/bin/bash

RUN="/usr/local/bin/dagger do -f ./queries.graphql"
CACHE=$($RUN Cache | jq -r '.cacheVolume.id')

WORKFS=$($RUN Workdir | jq -r '.host.workdir.read.id')
GRADLE=$($RUN --set "workfs=$WORKFS" --set "cachevol=$CACHE" --set "cmd=run" Gradle | jq -r '.. | .contents? | select(. != null)')
echo $GRADLE 