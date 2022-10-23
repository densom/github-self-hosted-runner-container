#!/bin/bash

ORGANIZATION=$ORGANIZATION
ACCESS_TOKEN=$ACCESS_TOKEN

REG_TOKEN=$GITHUB_REG_TOKEN
GITHUB_URL=$GITHUB_URL
GITHUB_RUNNER_GROUP=$GITHUB_RUNNER_GROUP
GITHUB_RUNNER_NAME=$GITHUB_RUNNER_NAME
GITHUB_RUNNER_WORKDIR=$GITHUB_RUNNER_WORKDIR

if [ -z "$GITHUB_REG_TOKEN" ]; then
  echo "Container failed to start, please pass -e GITHUB_REG_TOKEN=<your token from github>"
  exit 1
fi

if [ -z "$GITHUB_URL" ]; then
  echo "Container failed to start, please pass -e GITHUB_URL=<your repo url from github>"
  exit 1
fi

cd /home/docker/actions-runner

./config.sh --url $GITHUB_URL --token ${REG_TOKEN} --name $GITHUB_RUNNER_NAME --work $GITHUB_RUNNER_WORKDIR --unattended

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!