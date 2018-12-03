#!/usr/bin/env bash

/usr/sbin/apache2ctl -D BACKGROUND && \
    cd /opt/primer-server/rest-api && \
    gunicorn --daemon -c gunicorn.conf server:app && bash