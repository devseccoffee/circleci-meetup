FROM maven:3.8.6-openjdk-18 as builder 

COPY . /usr/src/poc
WORKDIR /usr/src/poc
RUN mvn clean && mvn package

FROM registry.access.redhat.com/ubi8/httpd-24
USER root
#RUN mkdir /workdir && dnf update -y && dnf -y clean all --enablerepo='*' && rpm -e --nodeps $(rpm -qa '*rpm*' '*dnf*' '*libsolv*' '*hawkey*' 'yum*' 'curl')

RUN mkdir /workdir && echo "Hello World" > /var/www/html/index.html

COPY --from=builder /usr/src/poc/target/log4j-rce-1.0-SNAPSHOT-jar-with-dependencies.jar /workdir

USER 1001
