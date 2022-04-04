FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && \
    apt-get install nginx certbot -y

RUN mkdir -p /app /var/www/html/.well-known/acme-challenge
WORKDIR /app

RUN echo "http {server {listen 0.0.0.0:80; server_name example.com;\
    location /.well-known {root /var/www/html;}}} events {}" > /etc/nginx/nginx.conf
RUN touch /app/nginx.conf && echo "http {server {listen 0.0.0.0:80; server_name example.com;\
    location /.well-known {root /var/www/html;}}} events {}" > /app/nginx.conf

COPY ./run_nginx.bash /app

CMD bash /app/run_nginx.bash
