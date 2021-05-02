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
    	git submodule add $repo
  fi

done
git submodule init
#echo $GIT_IGNORE
#echo -e "$GIT_IGNORE">.gitignore
