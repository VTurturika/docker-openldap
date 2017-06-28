#!/bin/bash

if [ $# -eq 0 ]; then
    PORT=389
else
    PORT=$1
fi

ldapsearch -x -LLL -H ldap://:$PORT/ -b dc=example,dc=com
