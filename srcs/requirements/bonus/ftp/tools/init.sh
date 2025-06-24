#!/bin/sh

if [ ! -f "/etc/vsftpd/vsftpd.conf" ]; then

    mkdir -p /etc/vsftpd
    mkdir -p /var/www/html

    mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf

    echo "FTP_USER is: $FTP_USER"
    echo "FTP_PASSWORD is: $FTP_PASSWORD"

    adduser "$FTP_USER" --disabled-password
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
    chown -R "$FTP_USER:$FTP_USER" /var/www/html

    echo "$FTP_USER" >> /etc/vsftpd.userlist
fi

mkdir -p /var/run/vsftpd/empty
echo "FTP started on :21"
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
