FROM ubuntu:14.04

RUN apt-get update
RUN apt-get -y install curl git
RUN apt-get -y install apache2 libapache2-mod-php5 php-gettext php-pear php5 php5-cgi php5-cli php5-common php5-curl php5-dev php5-gd php5-gmp php5-imagick php5-intl php5-json php5-mcrypt php5-mysql php5-oauth php5-pspell php5-redis php5-sqlite php5-xcache php5-xmlrpc php5-xsl pkg-php-tools
COPY src/ioncube_loader_lin_5.5.so /usr/lib/php5/20121212/
COPY src/ioncube.ini /etc/php5/mods-available/
RUN php5enmod ioncube
RUN mv /etc/php5/apache2/conf.d/20-ioncube.ini /etc/php5/apache2/conf.d/05-ioncube.ini && mv /etc/php5/cli/conf.d/20-ioncube.ini /etc/php5/cli/conf.d/05-ioncube.ini && mv /etc/php5/cgi/conf.d/20-ioncube.ini /etc/php5/cgi/conf.d/05-ioncube.ini
RUN update-rc.d apache2 defaults
RUN php5enmod mcrypt
RUN a2enmod actions
RUN a2enmod cache
RUN a2enmod expires
RUN a2enmod file_cache
RUN a2enmod headers
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod rewrite
RUN a2enmod socache_shmcb
RUN a2enmod ssl
COPY src/kalbestore.conf /etc/apache2/sites-available/
RUN a2dissite 000-default.conf
RUN a2ensite kalbestore.conf
RUN useradd -m -s /bin/bash webadmin && mkdir -p /home/webadmin/sites/kalbestore && chown -R webadmin. /home/webadmin/sites/kalbestore
COPY src/envvars /etc/apache2/
EXPOSE 80 443
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

