# Nette on Azure Web App On Linux

Docker image for Nette web app, running on Azure Web App on Linux platform.

## What is inside
- nginx
- PHP 7 (fpm)
- scripts for cleaning cache

## Instalation

As <em>Container type</em> select <em>Docker Compose</em>, as <em>Registry source</em> select <em>Docker Hub</em>.

### Config <small>(paste following config in textarea on Azure Portal)</small>

```dockerfile
version: '3.3'
services:
  nginx:
    image: vjirovsky/azure-nette-nginx:latest
    #build: ./src/nginx

    restart: always

    ports:
      - 8000:80

    volumes:
      #following line is used for debugging at local computer
      #- ./var_www:/var/www/html
      #following lines are used for live app on Azure Web App, in case of WEBSITES_ENABLE_APP_SERVICE_STORAGE = true
      - ${WEBAPP_STORAGE_HOME}/site/wwwroot:/var/www/html
      - ${WEBAPP_STORAGE_HOME}/LogFiles:/var/log
    logging:
        driver: "json-file"
        options:
            max-file: "5"
            max-size: "5m"

    depends_on:
      - fpm
  fpm:
    image: vjirovsky/azure-nette-fpm:latest
    #build: ./src/php-fpm

    restart: always

    ports:
      - 9000:9000

    volumes:
      #following line is used for debugging at local computer
      #- ./var_www:/var/www/html
      #following lines are used for live app on Azure Web App, in case of WEBSITES_ENABLE_APP_SERVICE_STORAGE = true
      - ${WEBAPP_STORAGE_HOME}/site/wwwroot:/var/www/html
      - ${WEBAPP_STORAGE_HOME}/LogFiles:/var/log
    logging:
        driver: "json-file"
        options:
            max-file: "5"
            max-size: "5m"
    depends_on:
      - smtp

  smtp:
    image: mwader/postfix-relay
    restart: always
    environment:
      - POSTFIX_myhostname=YOURDOMAIN.COM
      - OPENDKIM_DOMAINS==YOURDOMAIN.COM

    mem_limit: "25000000"
    logging:
        driver: "json-file"
        options:
            max-file: "5"
            max-size: "5m" 

```

2. Ensure that folder /home/LogFiles/nginx exists
3. Set up application variable <em>WEBSITES_ENABLE_APP_SERVICE_STORAGE</em> to <em>true</em>, if you want to share /home/ dir (incl. temp && log folders) between nodes; in case you do not want to share dirs, delete <em>volumes</em> section.


## Example usage
1. your Nette web app should be in git repository
2. set up Local git deployment in Azure Portal under _Deployment options_
3. create your git credentials in Azure Portal under _Deployment credentials_

![Azure portal - Azure Web App On Linux - git credentials](https://raw.githubusercontent.com/vjirovsky/docker-azure-webapp-nette-nginx/master/docs/azure-git-credentials.png)

4. get your git repository URL in Azure Portal under _Overview_ -> _Git clone url_
5. add this as git remote repository
6. push to this repository
7. enjoy

## Debugging
Because Web apps on Linux are running on Microsoft's [Project Kudu](https://github.com/projectkudu/kudu), you can use [FTP connection](https://github.com/projectkudu/kudu/wiki/Accessing-files-via-ftp) or [Kudu console](https://github.com/projectkudu/kudu/wiki/Kudu-console) (limited remote Bash console) to connect to your app.

### Nette application

For debugging purposes I do recommend to add following code inside <em>bootstrap.php</em>:

```php
if (getenv('NETTE_DEBUG', true)) {
  $configurator->setDebugMode(TRUE);
}
```

Thanks to this code you can enable/disable Tracy debugging by Application settings (in Azure Portal) value of <em>NETTE_DEBUG</em> parameter (environment value).

### Logs
Nginx generates two logs

- access log - placed in /home/LogFiles/docker/nginx.access.log
- error log - placed in /home/LogFiles/docker/nginx.error.log

