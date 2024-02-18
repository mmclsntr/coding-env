#!/bin/bash

current_dir=$(pwd)
cd "$(dirname "$0")"

# install
version=$1

asdf plugin add python
asdf install python $version
asdf global python $version

# lsp
pip install python-language-server
