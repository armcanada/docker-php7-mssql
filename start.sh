#!/bin/bash

pkill -f httpd

/usr/sbin/httpd -DFOREGROUND
