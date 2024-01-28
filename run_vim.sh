#!/bin/bash

current_dir=$(pwd)

cd "$(dirname "$0")"

base=$1
file=$2

abs_dir=${current_dir#$HOME}
working_dir=${base%/}/${abs_dir#/}
echo $working_dir
echo $file

HOSTNAME=`hostname` docker compose exec -w $working_dir workspace /bin/bash -c "source ~/.bashrc && vim $file"
