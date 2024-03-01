#!/bin/bash

dir=$1
file=$2

echo $dir

cd "$(dirname "$0")"

base="/root/workdir"

working_dir=${base%/}/${dir#/}

echo $working_dir

if [ -z "$file" ]; then
	echo "no file is specified."
else
	echo $file
fi

HOSTNAME=`hostname` docker compose exec -w $working_dir workspace /bin/bash -c "source ~/.bashrc && vim $file"
