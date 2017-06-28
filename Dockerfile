FROM ubuntu

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends -y \
    slapd \
    ldap-utils \
    expect && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY scripts /scripts
RUN chmod +x /scripts/* && \
    cd scripts && \
    /bin/bash init.sh

RUN service slapd start

EXPOSE 389

CMD slapd -h 'ldap:/// ldapi:///' -g openldap -u openldap -F /etc/ldap/slapd.d -d stats
