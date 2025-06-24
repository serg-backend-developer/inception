FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y \
    wget \
    curl \
    php7.4-fpm \
    php7.4-mysql

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d

RUN mkdir -p /run/php && chown www-data:www-data /run/php

RUN mkdir -p /var/www/html

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

RUN mkdir -p /var/www/html/wp-content/plugins && \
    mkdir -p /var/www/html/wp-content/themes && \
    mkdir -p /var/www/html/wp-content/uploads && \
    chmod -R 755 /var/www/html/wp-content/plugins && \
    chmod -R 755 /var/www/html/wp-content/themes && \
    chmod -R 755 /var/www/html/wp-content/uploads

RUN chown -R www-data:www-data /var/www/html/wp-content && \
    chmod -R 755 /var/www/html/wp-content

WORKDIR /var/www/html/
COPY ./tools/run.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/run.sh"]
CMD ["php-fpm7.4", "-F"]
