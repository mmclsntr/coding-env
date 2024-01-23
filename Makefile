build-and-start:
	HOSTNAME=`hostname` docker compose up -d --build

start:
	HOSTNAME=`hostname` docker compose up -d

workspace:
	HOSTNAME=`hostname` docker compose exec workspace /bin/bash -c "source ~/.bashrc && vim"

term:
	HOSTNAME=`hostname` docker compose exec workspace bash
