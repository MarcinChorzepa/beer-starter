#!/usr/bin/env bash
BRANCH=${1:-master}
if
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

#fetching repos from submodule
for repo in "${EMOBLILITY_GIT[@]}"
do
  NAME=$repo
  NAME=${NAME#*/}
  NAME=${NAME%.*}
  if [ -d $NAME ]
  then
  echo "fetching repo $NAME"
    if cd $NAME && \
        git fetch && \
        git fetch --tags && \
        git checkout $BRANCH >/dev/null; then
        cd ..
        git add $NAME
        git commit -m "Update the submodule to the $BRANCH version" $NAME
    else
        echo "Branch or project not found"
        cd ..
    fi
  fi
done
