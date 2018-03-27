#!/bin/bash



export PORT=5104
export MIX_ENV=prod
export GIT_PATH=/home/webuser1/answer-game

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "webuser1" ]; then
	echo "Error: must run as user 'webuser1'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/gameproject ]; then
	echo mv ~/www/gameproject ~/old/$NOW
	mv ~/www/gameproject ~/old/$NOW
fi

mkdir -p ~/www/gameproject
REL_TAR=~/answer-game/_build/prod/rel/gameproject/releases/0.0.1/gameproject.tar.gz
(cd ~/www/gameproject && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/webuser1/answer-game/start.sh
CRONTAB

#. start.sh
