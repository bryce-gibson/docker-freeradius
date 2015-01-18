#!/bin/bash

env | while read line; do
  if [[ "$line" != RADIUS_USER_* ]]; then continue; fi
  user=${line/RADIUS_USER_/}
  username=${user%=*}
  password=${user#*=}
  echo "${username} Cleartext-Password := \"${password}\"" >> /etc/freeradius/users
  [[ "$QUIET" == 'true' ]] || echo "Added user ${username} with password ${password}"
done

exec /usr/sbin/freeradius -X
