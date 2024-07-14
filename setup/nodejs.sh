#!/bin/bash -xe

current_dir=$(pwd)
cd "$(dirname "$0")"

# install
version=$1

asdf plugin add nodejs
asdf install nodejs $version

asdf reshim nodejs

asdf global nodejs $version

# lsp
npm install -g typescript-language-server typescript
