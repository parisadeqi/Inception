BASE_DIR = /home/psadeghi
WP_DATA = $(BASE_DIR)/data/wordpress
DB_DATA = $(BASE_DIR)/data/mariadb

# default target
all: up

# start the building process
# create the wordpress and mariadb data directories.
# start the containers in the background and leaves them running


up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker-compose -f ./srcs/docker-compose.yml up -d

# build the containers
build:
	docker-compose -f ./srcs/docker-compose.yml build
# stop the containers
down:
	docker-compose -f ./srcs/docker-compose.yml down

# stop the containers
stop:
	docker-compose -f ./srcs/docker-compose.yml stop

# start the containers
start:
	docker-compose -f ./srcs/docker-compose.yml start


kill:
	docker-compose -f srcs/docker-compose.yml kill

wp:
	docker exec -it wordpress bash

logs:
	docker-compose -f srcs/docker-compose.yml logs
# clean the containers
# stop all running containers and remove them.
# remove all images, volumes and networks.
# remove the wordpress and mariadb data directories.
# the (|| true) is used to ignore the error if there are no containers running to prevent the make command from stopping.

clean:
#	docker system prune -a
#	@docker volume rm $$(docker volume ls -q) || true
#	docker-compose -f ./srcs/docker-compose.yml down -v --rmi all --remove-orphans
#	@sudo rm -rf $(WP_DATA) || true
#	@sudo rm -rf $(DB_DATA) || true
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true
	@sudo rm -rf $(WP_DATA) || true
	@sudo rm -rf $(DB_DATA) || true

# clean and start the containers
re: clean up

# prune the containers: execute the clean target and remove all containers, images, volumes and networks from the system.
prune: clean
	@docker system prune -a --volumes -f


 #docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null