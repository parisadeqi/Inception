
# Description: MariaDB Dockerfile

# pull base image
FROM debian:bullseye

# update and upgrade the system
RUN apt-get update && apt-get upgrade -y

# # install the required packages
RUN apt-get install -y mariadb-server nano

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

# copy file from host to container
COPY ./tools/mdb_conf.sh /mdb_conf.sh

# set permissions to the file
RUN chmod +x /mdb_conf.sh

# define entrypoint command to run when the container starts
ENTRYPOINT ["./mdb_conf.sh"]

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

# sudo exec -it 'containername' (to enter running container)
# look for files execute cmds like ls, cat

# if in maria container then type: "mariadb -u root -p"
# then check "SHOW DATABASES;"