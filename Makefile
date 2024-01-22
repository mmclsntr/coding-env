build-and-start:
	HOSTNAME=`hostname` docker compose up -d --build

start:
	HOSTNAME=`hostname` docker compose up -d

workspace:
	HOSTNAME=`hostname` docker compose exec workspace vim

term:
	HOSTNAME=`hostname` docker compose exec workspace bash
