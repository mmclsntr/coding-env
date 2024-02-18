#!/bin/bash -xe

if [ $# != 1 ]; then
    echo "Specify work directory path."
    exit 1
fi

current_dir=$(pwd)

cd "$(dirname "$0")"

prj_path=$1

export HOSTNAME=`hostname` 

# create workdir link
rm -f workdir
ln -s $prj_path workdir

# setup env
docker compose up -d --build
docker compose exec workspace /bin/bash -c "source ~/.bashrc && bash ~/setup/run.sh"

# install vim plugins
docker compose exec workspace /bin/bash -c "source ~/.bashrc && vim -c PlugInstall -c qa"
