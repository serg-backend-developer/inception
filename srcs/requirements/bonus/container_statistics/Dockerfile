FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get purge -y nodejs npm nodejs-legacy && \
    apt-get install -y curl supervisor sqlite3 git

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

RUN git clone https://github.com/virtualzone/docker-container-stats.git /opt/docker-stats && \
    cp /opt/docker-stats/supervisord.conf /etc/supervisord.conf

RUN cd /opt/docker-stats && \
    npm update && \
    npm install express sqlite3 body-parser moment

RUN mkdir -p /opt/docker-stats/db

EXPOSE 8080

CMD ["supervisord"]
