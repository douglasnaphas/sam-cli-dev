#!/usr/bin/env bash

source .env
docker build --tag douglasnaphas/sam-cli-dev:${GIT_BRANCH} \
  --build-arg GIT_REPO=${GIT_REPO} \
  --build-arg GIT_NAMESPACE=${GIT_NAMESPACE} \
  --build-arg GIT_BRANCH=${GIT_BRANCH} .