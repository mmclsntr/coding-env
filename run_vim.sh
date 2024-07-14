#!/bin/bash -e


current_dir=$(pwd)

cd "$(dirname "$0")"

sub=$1
path=$2

base="/root/workdir"


if [ -z "$path" ]; then
	echo "no file is specified."
    abs_dir=${current_dir#$HOME}
    working_dir=${base%/}/${abs_dir#/}
    filename=""
else
	echo "file: $path"
    filedir=$(dirname "$path")
    filename=$(basename "$path")
    abs_dir=${current_dir#$HOME}/${filedir}
    working_dir=${base%/}/${abs_dir#/}
fi

if [ "$sub" == "restore" ]; then
    restore_cmd="-c 'call Restore_session()'"
else
    restore_cmd=""
fi

echo "file name: ${working_dir}"
echo "working_dir: ${working_dir}"

xhost + localhost && HOSTNAME=`hostname` docker compose exec -w $working_dir workspace /bin/bash -c "source ~/.bashrc && vim $restore_cmd $filename"
