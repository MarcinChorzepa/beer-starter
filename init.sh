#!/usr/bin/env bash
source config/config.sh
for repo in "${EMOBLILITY_GIT[@]}"
do
  NAME=$repo
  NAME=${NAME#*/}
  NAME=${NAME%.*}
  if [ -d $HOME_DIR/$NAME ]
  then
    echo "repository $NAME exists. (skipping)"
  else
    	echo "clonning repo $repo"
    	git submodule add $repo
  fi
#	GIT_IGNORE=$GIT_IGNORE"/"$NAME"\n"

done
#echo $GIT_IGNORE
#echo -e "$GIT_IGNORE">.gitignore
