#!/bin/bash

if [ -z ${PASSWORD+x} ] || [ ${#PASSWORD} -eq 0 ]; then
    PASSWORD="secret"
fi

cd /scripts
HASHED_PASSWORD=$(./generate.exp $PASSWORD | grep ^{SSHA})

ldapsearch -H ldapi:// -LLL -Q -Y EXTERNAL -b "cn=config" "(olcRootDN=*)" dn olcRootDN olcRootPW > root.ldif
sed -i "s?olcRootPW.*?olcRootPW: $HASHED_PASSWORD?" root.ldif
sed -i "s/olcRootDN.*/changetype: modify\nreplace: olcRootPW/" root.ldif
ldapmodify -H ldapi:// -Y EXTERNAL -f root.ldif

ldapsearch -H ldapi:// -LLL -Q -Y EXTERNAL -b "cn=config" "(olcRootDN=*)" dn olcRootDN olcRootPW > admin.ldif
sed -i "s/dn:.*//" admin.ldif
sed -i "s/olcRootDN/dn/" admin.ldif
sed -i "s?olcRootPW.*?changetype: modify\nreplace: userPassword\nuserPassword: $HASHED_PASSWORD?" admin.ldif
DIT=$(cat admin.ldif | grep dn | sed "s/dn: //")
OLD_PASSWORD=$(<old_pswd)
ldapmodify -H ldap:// -x -D "$DIT" -w "$OLD_PASSWORD" -f admin.ldif

rm root.ldif admin.ldif
echo $PASSWORD > old_pswd
