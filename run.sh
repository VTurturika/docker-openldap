#!/bin/bash

if [ $# -eq 0 ]; then
    echo "usage: $0 PASSWORD [PORT=389]"
    exit;
elif [ "$#" -eq 1 ]; then
    PASSWORD="$1";
    PORT=389
else
    PASSWORD="$1"
    PORT=$2
fi

printf "Starting container...\n"
if [ $PORT -gt 1024 ]; then
    CONTAINER=$(docker run -d -p $PORT:389 --env PASSWORD="$PASSWORD" vturturika/ldap);
else
    printf "Trying to use $PORT port. You must have been admin\n"
    CONTAINER=$(sudo docker run -d -p $PORT:389 --env PASSWORD="$PASSWORD" vturturika/ldap);
fi
printf "Done\n"
echo $CONTAINER > container_hash

printf "Setting new password... \n"
docker exec $CONTAINER /bin/bash /scripts/change.sh
printf "Done\n"
