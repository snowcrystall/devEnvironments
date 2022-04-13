#!/bin/sh

service postgresql start
service redis-server start
service nginx start

/home/git/init.d/gitlab start


