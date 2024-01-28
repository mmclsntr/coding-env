#!/bin/bash -xe

current_dir=$(pwd)

cd "$(dirname "$0")"

export HOSTNAME=`hostname` 

# setup env
docker compose up -d --build
docker compose exec workspace /bin/bash -c "source ~/.bashrc && bash ~/setup/run.sh"

# install vim plugins
docker compose exec workspace /bin/bash -c "source ~/.bashrc && vim -c PlugInstall -c qa"
