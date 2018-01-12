FROM centos:centos7

# ARM Canada
MAINTAINER nboisvert@armcanada.ca

#   Installs the EPEL and Webtatic repositories
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

#   Updates the container
RUN yum update -y

#   Install all the requirement for HTTPD, PHP and MSSQL driver
RUN yum install -y \
    wget php70w php70w-gd \
    php70w-common php70w-fpm \
    php70w-mbstring php70w-mysql \
    php70w-odbc php70w-pdo php70w-xml \
    freetds php70w-pdo_dblib httpd

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

#   Creates app Direcrory
RUN mkdir /app
RUN mkdir /app/public

#   Sets the working directory
WORKDIR /app

#   Starts HTTPD
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
