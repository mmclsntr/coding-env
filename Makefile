build-and-start:
	docker compose up -d --build

start:
	docker compose up -d

workspace:
	docker compose exec workspace bash
