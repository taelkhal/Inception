FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx

COPY ./ssl/taelkhal.42.fr.crt /etc/nginx/ssl/

COPY ./ssl/taelkhal.42.fr.key /etc/nginx/ssl/

COPY nginx.conf /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]