# Pulling our base image
FROM debian:bullseye

# Install PHP-FPM and MySQL extensions
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install php-fpm php7.4-mysqlnd mariadb-client -y \
    && apt-get install curl wget -y

# Copy the shell script for our WordPress configuration
COPY ./conf/script.sh .

# Give execute permissions to the shell script
RUN chmod +x script.sh

# Set the default command to execute the shell script when the container starts
CMD ["/script.sh"]