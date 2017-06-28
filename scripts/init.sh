
LDAP_ADMIN_PASSWORD="secret"
LDAP_DOMAIN="example.com"
LDAP_ORGANISATION="orgname"
LDAP_BACKEND="hdb"

echo $LDAP_ADMIN_PASSWORD > old_pswd

cat <<EOF | debconf-set-selections
slapd slapd/internal/generated_adminpw password ${LDAP_ADMIN_PASSWORD}
slapd slapd/internal/adminpw password ${LDAP_ADMIN_PASSWORD}
slapd slapd/password2 password ${LDAP_ADMIN_PASSWORD}
slapd slapd/password1 password ${LDAP_ADMIN_PASSWORD}
slapd slapd/domain string ${LDAP_DOMAIN}
slapd shared/organization string ${LDAP_ORGANISATION}
slapd slapd/backend string ${LDAP_BACKEND}
slapd slapd/purge_database boolean true
slapd slapd/move_old_database boolean false
slapd slapd/allow_ldap_v2 boolean false
EOF
dpkg-reconfigure -f noninteractive slapd
