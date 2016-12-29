# Nette on Azure Web App On Linux

Docker image for Nette web app, running on Azure Web App on Linux platform 

## What is inside
- nginx
- PHP 7

## Instalation

As image and optional tag (eg 'image:tag') type: 
```
vjirovsky/azure-webapp-nette-nginx
```

As startup Command type only:
```
-P
```


![Azure portal](https://raw.githubusercontent.com/username/vjirovsky/docker-azure-webapp-nette-nginx/docs/azure.png)


## Logs
Nginx generates two logs

- access log - placed in /home/LogFiles/docker/nginx.access.log
- error log - placed in /home/LogFiles/docker/nginx.error.log


## Contribution


based on Docker [image andreisusanu/docker-nginx-php7](andreisusanu/docker-nginx-php7)

