# Nette on Azure Web App On Linux

Docker image for Nette web app, running on Azure Web App on Linux platform 

## What is inside
- nginx
- PHP 7 (fpm)
- supervisord

## Instalation

As image and optional tag (eg 'image:tag') type: 
```
vjirovsky/azure-webapp-nette-nginx
```

As startup Command type only:
```
-P
```

![Azure portal - Azure Web App On Linux Docker container](https://raw.githubusercontent.com/vjirovsky/docker-azure-webapp-nette-nginx/master/docs/azure-docker.png)

## Usage example
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

### Logs
Nginx generates two logs

- access log - placed in /home/LogFiles/docker/nginx.access.log
- error log - placed in /home/LogFiles/docker/nginx.error.log


## Contribution


based on Docker [image andreisusanu/docker-nginx-php7](andreisusanu/docker-nginx-php7)

