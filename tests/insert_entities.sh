#!/bin/bash

if [ $# -eq 0 ]; then
    PORT=389
else
    PORT=$1
fi

touch entities.ldif

for (( i = 0; i < 3; i++ )); do

    CN=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 24 | head -n 1)
    SN=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 12 | head -n 1)

    echo "dn: cn=$CN,ou=People,dc=example,dc=com" >> entities.ldif
    echo "objectClass: person" >> entities.ldif
    echo "sn: $SN" >> entities.ldif
    echo "cn: $CN" >> entities.ldif
    echo "" >> entities.ldif

done

ldapadd -x -H ldap://:$PORT/  -D cn=admin,dc=example,dc=com -W -f entities.ldif
rm entities.ldif
