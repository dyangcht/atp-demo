FROM oraclelinux:7-slim

RUN yum install -y oracle-release-el7 && yum-config-manager --enable ol7_oracle_instantclient && \
    yum install -y oracle-instantclient19.3-basic && yum install -y oracle-nodejs-release-el7 && rm -rf /var/cache/yum
RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash - && yum install -y nodejs && rm -rf /var/cache/yum
ENV NODE_ORACLEDB_PASSWORD=Welcome123456 \
    NODE_ORACLEDB_CONNECTIONSTRING=orcl_low

COPY wallet/* /usr/lib/oracle/19.3/client64/lib/network/admin/
COPY *.js /root/
WORKDIR /root
RUN npm install oracledb

EXPOSE 7000
# CMD node example.js
CMD node webappawait.js
