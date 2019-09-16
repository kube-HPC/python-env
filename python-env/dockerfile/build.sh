#!/usr/bin/env bash
REPO_NAME=$1
BASE_PYTHON=${2}
NAME_POSTFIX=""
if [ -z ${BASE_PYTHON}]; then
  NAME_POSTFIX=""
else
  NAME_POSTFIX=-${BASE_PYTHON}
fi
if [ -v PRIVATE_REGISTRY ]
then
  IMAGE_NAME=${PRIVATE_REGISTRY}/${REPO_NAME}
else
  IMAGE_NAME=hkube/${REPO_NAME}
fi
echo npm_package_version=${npm_package_version}
VERSION="v${npm_package_version}"
if [ "${TRAVIS_PULL_REQUEST:-"false"}" != "false" ]; then
  VERSION=${VERSION}-${TRAVIS_PULL_REQUEST_BRANCH}-${TRAVIS_JOB_NUMBER}
fi
TAG_VER="${IMAGE_NAME}${NAME_POSTFIX}:${VERSION}"

docker build -t ${TAG_VER} -f ./python-env/dockerfile/Dockerfile${NAME_POSTFIX} ./python-env

if [ -v PRIVATE_REGISTRY ]
then
  echo docker push ${TAG_VER}
  docker push ${TAG_VER}
fi

