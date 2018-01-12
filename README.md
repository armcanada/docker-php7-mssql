# docker-php7-mssql
Docker image for PHP7 with MSSQL drivers running on a CentOS host.

### What's in the box?

#### Repos

- EPEL
- Webtatic

#### Packages
- wget
- httpd
- php-7
- freetds
- composer

#### PHP extensions
- php-gd
- php-common
- php-fpm
- php-common
- php-mbstring
- php-mysql
- php-odbc
- php-pdo
- php-xml
- php-pdo-dblib

### Document root

The official folder serviced by Apache is `/app/public`. The setup is primarily build for Laravel deployment. If it's your case, mount your app to `/app` so the Laravel's public folder will serviced as sepected


#### Laravel case

If you are deploying a Laravel project, you may need to use `artisan`. To do so, you only have to run `docker exec -it my_container php artisan {command}`. The working directory is by default set to `/app`
