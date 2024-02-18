#!/bin/bash


current_dir=$(pwd)

cd "$(dirname "$0")"

file=$1

base="/root/workdir"

abs_dir=${current_dir#$HOME}
working_dir=${base%/}/${abs_dir#/}

echo $working_dir

if [ -z "$file" ]; then
	echo "no file is specified."
else
	echo $file
fi


HOSTNAME=`hostname` docker compose exec -w $working_dir workspace /bin/bash -c "source ~/.bashrc && vim $file"
