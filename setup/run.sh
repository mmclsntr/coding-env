#!/bin/bash -xe

current_dir=$(pwd)
cd "$(dirname "$0")"

custom_dir="../custom"

setup_config_file="${custom_dir}/setup_config.json"

if [ -f $setup_config_file ]; then
    setup_config=`cat $setup_config_file`
else
    # no language server
    setup_config="{}"
fi

echo $setup_config

# install nodejs
nodejs_version=`echo $setup_config | jq -r ".nodejs.version // empty"`
if [ -n "$nodejs_version" ]; then
    ./nodejs.sh $nodejs_version
fi

# install python
python_version=`echo $setup_config | jq -r ".python.version // empty"`
if [ -n "$python_version" ]; then
	./python.sh $python_version
fi

# install golang
golang_version=`echo $setup_config | jq -r ".golang.version // empty"`
if [ -n "$golang_version" ]; then
	./golang.sh $golang_version
fi

# install java
java_version=`echo $setup_config | jq -r ".java.version // empty"`
if [ -n "$java_version" ]; then
	./java.sh $java_version
fi

# Install LSP for text types
./text_types.sh
