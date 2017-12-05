#!/bin/bash
set -e

if [ "x$CIFS_SOURCE" != "x" ]; then
  test -z $CIFS_TARGET && CIFS_TARGET='/usr/share/logstash/data'
  test -z $CIFS_USER && CIFS_USER=guest
  test -z $CIFS_PASS && CIFS_PASS=guest
  test -z $CIFS_VERS && CIFS_VERS='3.0'
  mount -t cifs -F -o username=$CIFS_USER,password=$CIFS_PASS,vers=$CIFS_VERS,uid=999,gid=999 $CIFS_SOURCE $CIFS_TARGET
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
        set -- logstash "$@"
fi

# Run as user "logstash" if the command is "logstash"
# allow the container to be started with `--user`
if [ "$1" = 'logstash' -a "$(id -u)" = '0' ]; then
        set -- gosu logstash "$@"
fi

exec "$@"
