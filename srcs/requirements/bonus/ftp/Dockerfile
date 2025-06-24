FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y vsftpd ftp

COPY ./conf/vsftpd.conf /tmp/vsftpd.conf
COPY ./tools/init.sh /init.sh

RUN chmod +x /init.sh

CMD ["/init.sh"]
