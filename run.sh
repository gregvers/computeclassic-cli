#!/bin/bash

# IDENTITYDOMAIN, COMPUTE_ENDPOINT, USER and PASSWORD are set
# DNS1 and DNS2 are optional

mkdir -p /root/.opc/profiles/
cat /root/.opc/profiles/profile-template.json | sed "s|USER|$USER|g" | sed "s|COMPUTE_ENDPOINT|${COMPUTE_ENDPOINT#*//}|g" | sed "s|IDENTITYDOMAIN|$IDENTITYDOMAIN|g" > /root/.opc/profiles/profile.json
echo $PASSWORD > /root/.opc/passwordfile
chmod -R 600 /root/.opc

if [ "$DNS1" != "" ]
then
  echo "nameserver" $DNS1 > /etc/resolv.conf
  if [ "$DNS2" != "" ]
  then
    echo "nameserver" $DNS2 >> /etc/resolv.conf
  fi
fi

echo 'PS1="/Compute-$IDENTITYDOMAIN/$USER  \w\$ "' >> /root/.bashrc

exec /bin/bash
