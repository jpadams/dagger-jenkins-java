#!/bin/bash

#set -x

RUN="/usr/local/bin/dagger do -f ./queries.graphql"

WORKFS=$($RUN Workdir | jq -r '.host.workdir.read.id')

GRADLE=$($RUN --set "workfs=$WORKFS" --set "cmd=run" Gradle)

echo $GRADLE | jq -r '.. | .contents? | select(. != null)'
