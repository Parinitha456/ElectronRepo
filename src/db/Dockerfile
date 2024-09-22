FROM mysql:9.0.1-oraclelinux9

MAINTAINER me

ENV MYSQL_ALLOW_EMPTY_PASSWORD="yes"

ADD schema.sql /docker-entrypoint-initdb.d

EXPOSE 3306