#!/bin/bash

CONTAINER=$(<container_hash)
docker stop $CONTAINER > /dev/null
rm -f container_hash
