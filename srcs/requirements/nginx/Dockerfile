FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/taelkhal.42.fr.crt -keyout /etc/nginx/ssl/taelkhal.42.fr.key -subj \
        "/C=MA/ST=REHAMNA/L=BENGUERIR/O=1337/OU=1337 \
        /CN=taelkhal.42.fr/UID=taelkhal"

COPY ./conf/nginx.conf /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]