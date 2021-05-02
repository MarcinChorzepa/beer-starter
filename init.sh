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

#fetching repos from submodule
for repo in "${EMOBLILITY_GIT[@]}"
do
  NAME=$repo
  NAME=${NAME#*/}
  NAME=${NAME%.*}
  if [ -d $NAME ]
  then
  echo "fetching repo $NAME"
  cd $NAME && \
      git fetch && \
      git fetch --tags && \
      git checkout master
  cd ..
  git add $NAME
  git commit -m 'Update the submodule to the "my-tag" version' $NAME

  fi
done
