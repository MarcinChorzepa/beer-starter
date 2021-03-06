#!/usr/bin/env bash
BRANCH=${1:-master}
source config/config.sh

echo $BRANCH
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
    	git config submodule.$NAME.active true
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

    if  cd $NAME && git fetch && \
        git fetch --tags && \
        git checkout $BRANCH>/dev/null;
    then
        git pull
        cd ..
        git add $NAME
        git commit -m "Update the submodule to the $BRANCH version" $NAME
    else
        echo "Branch $BRANCH or project $NAME not found"
        cd ..
    fi
  fi
done