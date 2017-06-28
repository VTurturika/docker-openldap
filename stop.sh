#!/bin/bash

CONTAINER=$(<container_hash)
docker stop $CONTAINER > /dev/null
rm container_hash
