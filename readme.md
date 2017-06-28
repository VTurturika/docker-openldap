# Dockerized OpenLDAP server
## Prerequirements

* installed ``docker`` on your machine ([installation guides](https://docs.docker.com/engine/installation/)).

## Bulding and running

1. Clone source code of image:
    ````
    git clone https://github.com/VTurturika/docker-openldap.git && cd docker-openldap
    ````
2. Build image:
    ````
    docker build -t vturturika/ldap .
    ````
3. Run container:
    ````
    ./run.sh LDAP_PASSWORD [LDAP_PORT=389]
    ````
4. For stopping container just type
    ````
    ./stop.sh
    ````

## Running without building

You may run container without bulding image, just clone [repo](https://github.com/VTurturika/docker-openldap.git) and run script:
````
./run.sh LDAP_PASSWORD [LDAP_PORT=389]
````

## Testing server

1. Go to `tests/` folder
    ````
    cd tests/
    ````
2. Insert group entity (only once)
    ````
    ./insert_group.sh [PORT=389]
    ````
3. Insert child entities (may inserted many times)
    ````
    ./insert_entities.sh [PORT=389]
    ````
4. Select all records from server
    ````
    ./select.sh [PORT=389]
    ````

## Extended usage

* Pulling without running
````
docker pull vturturika/ldap
````
* Running without script
````
docker run -d -p HOST_PORT:389 vturturika/ldap
````
* Default values for `slapd` located [here](https://github.com/VTurturika/docker-openldap/blob/master/scripts/init.sh). You may set another values.
