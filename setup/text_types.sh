#!/bin/bash -xe

current_dir=$(pwd)
cd "$(dirname "$0")"

# lsp
# HTML / CSS / Json
npm install -g vscode-langservers-extracted

# docker
npm install -g dockerfile-language-server-nodejs

# Yaml
npm install -g yaml-language-server

# Vim
npm install -g vim-language-server
