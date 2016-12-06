FROM ubuntu:14.04
MAINTAINER OEMS <oscaremu@gmaiil.com>

RUN apt-get update && \
    apt-get install -y curl supervisor git php5 php5-mysql php5-gd libapache2-mod-php5 php5-curl libssh2-php apache2 mysql-server wget

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV WIKKAWIKI_VERSION 1.3.5-m1
ENV MD5_CHECKSUM 11f31352e708e1f8df835369283eb0d1

ADD https://github.com/pepitosoft/wikkademo/archive/$WIKKAWIKI_VERSION.tar.gz /var/www/html/wikka/

RUN mkdir -p /var/www/html/wikka \
    && cd /var/www/html/wikka \
    && echo "$MD5_CHECKSUM $WIKKAWIKI_VERSION.tar.gz" | md5sum -c - \
    && tar xzf "$WIKKAWIKI_VERSION.tar.gz" --strip 1 \
    && rm "$WIKKAWIKI_VERSION.tar.gz"

ADD wikka.conf /etc/apache2/sites-available/wikka.conf
ADD mysql_wikkawiki.sql /root/mysql_wikkawiki.sql
ADD supervisord.conf /etc/supervisord.conf
ADD fix_perm.sh /root/fix_perm.sh

RUN chown -R www-data:www-data /var/www \
    && a2enmod rewrite \
    && rm /etc/apache2/sites-enabled/000-default.conf \
    && ln -s /etc/apache2/sites-available/wikka.conf /etc/apache2/sites-enabled/

RUN service mysql start & \
    sleep 10s  \
    && mysql -u root < /root/mysql_wikkawiki.sql

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
