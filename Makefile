all: build

down:
	@docker-compose -f ./srcs/docker-compose.yml down

build:
	@docker-compose -f ./srcs/docker-compose.yml up --build

re:
	@docker-compose -f ./srcs/docker-compose.yml down
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

clean: down
	@docker system prune -af
	@docker image rm nginx || true
	@docker image rm wordpress || true
	@docker image rm mariadb || true
	@docker volume rm mdb-vol wp-vol || true
	@sudo rm -rf /home/taelkhal/data/mariadb/*
	@sudo rm -rf /home/taelkhal/data/wordpress/*