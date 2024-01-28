#!/bin/bash +xe

current_dir=$(pwd)
cd "$(dirname "$0")"

setup_config_file="../custom/setup_config.json"
setup_config=`cat $setup_config_file`

echo $setup_config

# install nodejs
nodejs_version=`echo $setup_config | jq -r .nodejs.version`
bash nodejs.sh $nodejs_version

# install python
python_version=`echo $setup_config | jq -r .python.version`
bash python.sh $python_version

# install golang
golang_version=`echo $setup_config | jq -r .golang.version`
bash golang.sh $golang_version

# install java
java_version=`echo $setup_config | jq -r .java.version`
bash java.sh $java_version

# Install LSP for text types
bash text_types.sh
