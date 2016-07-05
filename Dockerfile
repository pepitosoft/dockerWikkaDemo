FROM ubuntu:14.04
MAINTAINER OEMS <oscaremu@gmaiil.com>

RUN apt-get update && \
    apt-get install -y curl supervisor php5 php5-mysql php5-gd libapache2-mod-php5 php5-curl libssh2-php apache2 mysql-server

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV WIKKAWIKI_VERSION 1.3.7
ENV MD5_CHECKSUM 9e3ae79d96bf0581c01e1dc706698576

RUN mkdir -p /var/www/html \
    && cd /var/www/html \
    && curl -O "http://wikkawiki.org/downloads/Wikka-$WIKKAWIKI_VERSION.tar.gz" \
    && echo "$MD5_CHECKSUM  Wikka-$WIKKAWIKI_VERSION.tar.gz" | md5sum -c - \
    && tar xzf "Wikka-$WIKKAWIKI_VERSION.tar.gz" --strip 1 \
    && rm "Wikka-$WIKKAWIKI_VERSION.tar.gz"

RUN chown -R www-data:www-data /var/www \
    && rm /var/www/html/index.html

#RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini
#RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
#RUN echo "daemon off;" >> /etc/nginx/nginx.conf
#RUN rm /etc/nginx/sites-enabled/*
#ADD dokuwiki.conf /etc/nginx/sites-enabled/

ADD mysql_wikkawiki.sql /root/mysql_wikkawiki.sql
ADD supervisord.conf /etc/supervisord.conf

RUN service mysql start & \
    sleep 10s && \
    mysql -u root < /root/mysql_wikkawiki.sql


#EXPOSE 80
#VOLUME [ \
#    "/var/www/data/pages", \
#    "/var/www/data/meta", \
#    "/var/www/data/media", \
#    "/var/www/data/media_attic", \
#    "/var/www/data/media_meta", \
#    "/var/www/data/attic", \
#    "/var/www/conf", \
#    "/var/log" \
#]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

# wget http://wikkawiki.org/downloads/Wikka-1.3.7.zip
# unzip Wikka-1.3.7.zip
