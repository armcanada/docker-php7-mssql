FROM centos:centos8

# ARM Canada
MAINTAINER aduhaime@armcanada.ca

#   Installs the EPEL and Webtatic repositories
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-8.rpm

#   Updates the container
RUN yum update -y
RUN yum install yum-utils -y
RUN dnf module install php:remi-8.1 -y

#   Install all the requirement for HTTPD, PHP and MSSQL driver
RUN yum install -y \
    wget php php-gd \
    php-common php-fpm \
    php-mbstring php-mysql \
    php-odbc php-pdo php-xml \
    freetds php-pdo_dblib httpd \
    php-pecl-zip \
    git

#   Adds Composer installer to the container
ADD composer.sh /usr/local/bin/setup_composer
RUN chmod +x /usr/local/bin/setup_composer

#   Installs Composer
RUN setup_composer

#   Adds the httpd.conf file
ADD httpd.conf /etc/httpd/conf/httpd.conf
#   Adds the freetds.conf file (Config for MSSQL driver)
ADD freetds.conf /etc/freetds.conf
#   Adds the php.ini file
ADD php.ini /etc/php.ini

#   Moves the composer executable to a PATH folder
RUN mv composer.phar /usr/local/bin/composer

#   Adds server start script
ADD start.sh /usr/local/bin/start_httpd
RUN chmod +x /usr/local/bin/start_httpd

#   Creates app Direcrory
RUN mkdir /app
RUN mkdir /app/public

RUN mkdir -p /run/php-fpm

#   Sets the working directory
WORKDIR /app

EXPOSE 80 443

#   Starts HTTPD
CMD ["start_httpd"]
