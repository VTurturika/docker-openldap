#!/bin/bash

if [ $# -eq 0 ]; then
    PORT=389
else
    PORT=$1
fi

ldapadd -x -H ldap://:$PORT/  -D cn=admin,dc=example,dc=com -W -f groups.ldif
