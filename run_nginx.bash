#!/usr/bin/bash

if [ -f /etc/letsencrypt/live/$DOMAIN/fullchain.pem ]
then
    sed "s/example.com/$DOMAIN/" /etc/nginx/nginx.conf && \
    nginx -g "daemon off;"
else
    sed "s/example.com/$DOMAIN/" /etc/nginx/nginx.conf && \
    service nginx start && \
    certbot certonly -n --agree-tos -m dmitriyvasil@gmail.com --webroot --webroot-path /var/www/html -d dmitriyvasildomain.ddns.net && \
    cp /app/nginx.conf /etc/nginx/nginx.conf && \
    sed "s/example.com/$DOMAIN/" /etc/nginx/nginx.conf && \
    nginx -s stop && \
    nginx -g "daemon off;"
fi

