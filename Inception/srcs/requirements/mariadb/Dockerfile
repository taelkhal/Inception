FROM debian:bullseye

RUN apt-get update -y && apt-get install -y mariadb-server && \
    sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY conf/script.sh .

RUN chmod +x /script.sh

CMD ["./script.sh"]