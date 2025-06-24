FROM debian:bullseye-slim

RUN apt-get update &&\
	apt-get upgrade -y 

RUN apt-get -y install nginx && mkdir -p /run/nginx

COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www/site/
COPY index.html /var/www/site/

RUN mkdir -p /etc/ssl/certs
RUN mkdir -p /etc/ssl/private

RUN chown -R root:root /etc/ssl/certs
RUN chown -R root:root /etc/ssl/private

RUN chmod -R 600 /etc/ssl/certs
RUN chmod -R 600 /etc/ssl/private

COPY nginx.key /etc/ssl/private
COPY nginx.crt /etc/ssl/certs

RUN chmod 644 /var/www/site/index.html
RUN chmod 755 /var/www/site

CMD nginx -g "daemon off;"
