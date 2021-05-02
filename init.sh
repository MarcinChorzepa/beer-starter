#!/usr/bin/env bash
source config/config.sh
for repo in "${EMOBLILITY_GIT[@]}"
do
  NAME=$repo
  NAME=${NAME#*/}
  NAME=${NAME%.*}
  if [ -d $NAME ]
  then
    echo "repository $NAME exists. (skipping)"
  else
    	echo "clonning repo $repo"
    	git submodule add $repo $NAME
  fi
done
git submodule update --init --recursive
