#!/bin/bash

# IDENTITYDOMAIN, ENDPOINT, USER and PASSWORD are set

mkdir -p /root/.opc/profiles/
cat /root/.opc/profiles/profile-template.json | sed "s|USER|$USER|g" | sed "s|COMPUTE_ENDPOINT|${COMPUTE_ENDPOINT#*//}|g" | sed "s|IDENTITYDOMAIN|$IDENTITYDOMAIN|g" > /root/.opc/profiles/profile.json
echo $PASSWORD > /root/.opc/passwordfile
chmod -R 600 /root/.opc

echo 'PS1="/Compute-$IDENTITYDOMAIN/$USER  \w\$ "' >> /root/.bashrc

exec /bin/bash
