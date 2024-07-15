WP_DATA = /home/psadeghi/data/wordpress
DB_DATA = /home/psadeghi/data/mariadb
# WP_DATA = /Users/parisasadeqi/data/wordpress
# DB_DATA = /Users/parisasadeqi/data/mariadb

# default target
all: build up

# start the biulding process
# create the wordpress and mariadb data directories.
# start the containers in the background and leaves them running

up:
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker-compose -f ./srcs/docker-compose.yml up -d

# stop the containers
down:
	docker-compose -f ./srcs/docker-compose.yml down

# stop the containers
stop:
	docker-compose -f ./srcs/docker-compose.yml stop

# start the containers
start:
	docker-compose -f ./srcs/docker-compose.yml start

# build the containers
build:
	docker-compose -f ./srcs/docker-compose.yml build

mariadb:
	docker exec -it mariadb bash
# clean the containers
# stop all running containers and remove them.
# remove all images, volumes and networks.
# remove the wordpress and mariadb data directories.
# the (|| true) is used to ignore the error if there are no containers running to prevent the make command from stopping.

clean:
	docker-compose -f ./srcs/docker-compose.yml down -v --rmi all --remove-orphans
#	docker rmi -f $$(docker images -qa) || true
#	@docker stop $$(docker ps -qa) || true
#	@docker rm $$(docker ps -qa) || true
#	@docker volume rm $$(docker volume ls -q) || true
#	@sudo rm -rf $(WP_DATA) || true
#	@sudo rm -rf $(DB_DATA) || true

# clean and start the containers
re: clean up

# prune the containers: execute the clean target and remove all containers, images, volumes and networks from the system.
prune: clean
	@docker system prune -a --volumes -f