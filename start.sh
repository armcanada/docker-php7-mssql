#!/bin/bash

pkill -f httpd

rm -rf /var/run/httpd/httpd.pid

/usr/sbin/httpd -DFOREGROUND
