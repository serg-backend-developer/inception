FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y nginx openssl dialog apt-utils procps && \
    apt-get upgrade -y

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/C=CH/L=Paris/O=42/FR=login"

COPY ./conf/nginx.conf /etc/nginx/conf.d/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
