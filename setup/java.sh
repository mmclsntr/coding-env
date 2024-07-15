#!/bin/bash -xe

current_dir=$(pwd)
cd "$(dirname "$0")"

# install
version=$1

asdf plugin add java
asdf install java $version

asdf reshim java

asdf global java $version

# lsp
mkdir -p ~/javalsp/eclipse.jdt.ls
cd ~/javalsp/eclipse.jdt.ls
curl -L https://download.eclipse.org/jdtls/milestones/1.9.0/jdt-language-server-1.9.0-202203031534.tar.gz -O
tar xf jdt-language-server-1.9.0-202203031534.tar.gz
