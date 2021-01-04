FROM nginx:latest

ENV HOME_SITE "/var/www/html"

COPY ./default.conf /etc/nginx/conf.d/

EXPOSE 80

# copy nette delete cache script (script + installation of script)
# installation of script will be launched after start of docker image (because of mounting /home in Azure)
COPY scripts/delete-nette-cache.cmd /usr/bin/delete-nette-cache.cmd
COPY scripts/install-script-delete-nette-cache.sh /etc/my_init.d/300-install-script-delete-nette-cache.sh
#RUN chmod +x /etc/my_init.d/300-install-script-delete-nette-cache.sh 