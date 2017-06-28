#!/bin/bash

if [ $# -eq 0 ]; then
    echo "usage: $0 PASSWORD [PORT=4000]"
    exit;
elif [ "$#" -eq 1 ]; then
    PASSWORD="$1";
    PORT=4000
else
    PASSWORD="$1"
    PORT=$2
fi

printf "Starting container... "
CONTAINER=$(docker run -d -p $PORT:389 --env PASSWORD="$PASSWORD" ldap)
printf "Done\n"
echo $CONTAINER > container_hash

printf "Setting new password... \n"
docker exec $CONTAINER /bin/bash /scripts/change.sh
printf "Done\n"
