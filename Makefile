exec_cmd = xhost + localhost && HOSTNAME=`hostname` docker compose


build:
	${exec_cmd} build workspace

build-and-start:
	${exec_cmd} up workspace -d --build

start:
	${exec_cmd} up workspace -d

down:
	${exec_cmd} down workspace

vim:
	./run_vim.sh restore ${FILE}

vim-new:
	./run_vim.sh new ${FILE}

term:
	${exec_cmd} exec workspace bash

build-env:
	${exec_cmd} build build-env

build-and-start-env:
	${exec_cmd} up build-env -d --build

start-env:
	${exec_cmd} up build-env -d

down-env:
	${exec_cmd} down build-env

term-env:
	${exec_cmd} exec build-env bash
