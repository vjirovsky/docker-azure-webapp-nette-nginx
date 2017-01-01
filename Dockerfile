FROM phusion/baseimage

MAINTAINER Vaclav Jirovsky <vjirovsky@vjirovsky.cz>
#BASED on andreisusanu/nginx-php7 image

ENV DEBIAN_FRONTEND noninteractive

# add NGINX official stable repository
RUN echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/nginx.list

# add PHP7 unofficial repository (https://launchpad.net/~ondrej/+archive/ubuntu/php)
RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/php.list

# install packages
RUN apt-get update && \
    apt-get -y --force-yes --no-install-recommends install \
    supervisor \
    nginx \
    php7.0-fpm php7.0-cli php7.0-common php7.0-curl php7.0-gd php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-opcache php7.0-pgsql php7.0-soap php7.0-sqlite3 php7.0-xml php7.0-xmlrpc php7.0-xsl php7.0-zip

# configure NGINX as non-daemon
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# configure php-fpm as non-daemon
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf

RUN apt-get autoclean && apt-get -y autoremove

# copy config file for Supervisor
COPY config/supervisor/supervisord.conf /etc/

# backup default default config for NGINX
RUN cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

# copy local default config file for NGINX
COPY config/nginx/default /etc/nginx/sites-available/default


# php7.0-fpm will not start if this directory does not exist
RUN mkdir /run/php

RUN mkdir -p /usr/bin
RUN mkdir -p /etc/my_init.d


# debug on localhost
#RUN mkdir -p /home/site/wwwroot/www
#RUN mkdir -p /home/LogFiles
#RUN chmod 2777 -R /home/site/
#RUN chmod 2777 -R /home/LogFiles/

# supervisor daemon
COPY scripts/install-supervisord.sh /etc/my_init.d/100-supervisord.sh


# copy nette delete cache script (script + installation of script)
# installation of script will be launched after start of docker image (because of mounting /home in Azure)
COPY scripts/delete-nette-cache.cmd /usr/bin/delete-nette-cache.cmd
COPY scripts/install-script-delete-nette-cache.sh /etc/my_init.d/300-install-script-delete-nette-cache.sh
RUN chmod +x /etc/my_init.d/300-install-script-delete-nette-cache.sh 

# NGINX ports
EXPOSE 80

CMD ["/sbin/my_init"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

