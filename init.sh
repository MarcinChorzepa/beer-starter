#!/usr/bin/env bash
source config/config.sh
for repo in "${EMOBLILITY_GIT[@]}"
do
  NAME=$repo
  NAME=${NAME#*/}
  NAME=${NAME%.*}
#  if [ -d $NAME ]
#  then
#    echo "repository $NAME exists. (skipping)"
#  else
    	echo "clonning repo $repo"
    	git clone --recurse-submodules $repo
#  fi
GIT_IGNORE=$GIT_IGNORE"/"$NAME"\n"
done
#git submodule update
#git submodule init

#echo $GIT_IGNORE
echo -e "$GIT_IGNORE">.gitignore
