#!/bin/bash

pkill -f httpd

rm -rf /var/run/httpd/httpd.pid
rm -rf /run/httpd/*

/usr/sbin/php-fpm
/usr/sbin/httpd -DFOREGROUND