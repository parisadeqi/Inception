# Description: Wordpress Dockerfile

# pull the base image
FROM debian:bullseye

# update and upgrade the system
RUN apt-get update && apt-get install -y
# install the required packages
RUN apt-get install -y \
                wget \
                bash \
                curl \
                php \
                php7.4-fpm \
                php-mysql \
                mariadb-client \
                netcat

#COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d
# copy the wordpress configuration script to the root directory in the container
COPY ./conf/wp_conf.sh /

# change the permission of the script to make it executable
RUN  chmod +x wp_conf.sh

VOLUME ["/var/www/wordpress"]

# define the entrypoint command to run when the container starts
ENTRYPOINT ["./wp_conf.sh"]

EXPOSE 9000