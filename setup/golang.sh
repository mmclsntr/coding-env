#!/bin/bash -xe

current_dir=$(pwd)
cd "$(dirname "$0")"

# install
version=$1

asdf plugin add golang
asdf install golang $version

asdf reshim golang

asdf global golang $version

# lsp
go install -v golang.org/x/tools/gopls@latest
