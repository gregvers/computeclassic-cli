# computeclassic-cli
docker image to run Oracle Compute Classic CLI

Download the CLI installation bundle from OTN (http://www.oracle.com/technetwork/topics/cloud/downloads/opc-cli-3096036.html) and place the zip file in the same folder as the Dockerfile

BUILD:
docker build --build-arg IDENTITYDOMAIN=lalala --build-arg USER=greg@oracle.com --build-arg PASSWORD="XXX" --build-arg ENDPOINT=https://endpoint/ -t gregvers/computeclassic-cli .

RUN:
docker run -it --env-file config.env gregvers/computeclassic-cli

config.env example:
USER=gre@domain.com
PASSWORD=XXXXXXX
IDENTITYDOMAIN=myIdentityDomain
ENDPOINT=https://compute.uscom-central-1.oraclecloud.com/
