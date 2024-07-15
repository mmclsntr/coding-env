#!/bin/bash -e


current_dir=$(pwd)

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
    filedir=$(cd $(dirname $path); pwd)
    echo $filedir
    filename=$(basename "$path")
    abs_dir=${filedir#$HOME}
    working_dir=${base%/}/${abs_dir#/}
fi

if [ "$sub" == "restore" ]; then
    restore_cmd="-c 'call Restore_session()'"
else
    restore_cmd=""
fi

echo "file name: ${filename}"
echo "working_dir: ${working_dir}"

cd "$(dirname "$0")"

xhost + localhost && HOSTNAME=`hostname` docker compose exec -w $working_dir workspace /bin/bash -c "source ~/.bashrc && vim $restore_cmd $filename"
