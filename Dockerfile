# Dockerfile to run Oracle Compute Classic CLI and Terraform
FROM oraclelinux:7

RUN sed -i -e '/^\[main\]/aproxy=http://www-proxy-hqdc.us.oracle.com:80' /etc/yum.conf
RUN yum install -y git unzip
RUN yum clean all

COPY opc-cli.17.2.2.zip /tmp/
RUN cd /tmp && unzip opc-cli.17.2.2.zip
RUN rpm -ivh /tmp/opc-cli-17.2.2.x86_64.rpm
RUN mv /tmp/README.txt /root/CLI-README.txt
RUN rm -Rf /tmp/*

#ADD terraform /usr/bin
RUN cd /tmp && curl -O https://releases.hashicorp.com/terraform/0.11.2/terraform_0.11.2_linux_amd64.zip && unzip terraform_0.11.2_linux_amd64.zip
RUN mv /tmp/terraform /usr/bin
RUN rm -Rf /tmp/terraform*

ARG IDENTITYDOMAIN
ARG USER
ARG PASSWORD
ARG ENDPOINT
ENV IDENTITYDOMAIN=$IDENTITYDOMAIN
ENV USER=$USER
ENV PASSWORD=$PASSWORD
ENV ENDPOINT=$ENDPOINT

RUN mkdir -p /root/.opc/profiles/
COPY profile-template.json /root/.opc/profiles/
COPY run.sh /root
RUN chmod +x /root/run.sh
RUN echo 'PS1="/Compute-$IDENTITYDOMAIN/$USER  \w\$ "' >> /root/.bashrc

ENV OPC_PROFILE_FILE=profile.json

WORKDIR /root
ENTRYPOINT /root/run.sh
