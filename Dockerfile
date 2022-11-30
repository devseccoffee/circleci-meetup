FROM maven:3.8.6-openjdk-18 as builder 

COPY . /usr/src/poc
WORKDIR /usr/src/poc
RUN mvn clean && mvn package

FROM registry.access.redhat.com/ubi8/httpd-24
USER root

RUN  dnf update -y && dnf -y clean all --enablerepo='*' && rpm -e --nodeps $(rpm -qa '*rpm*' '*dnf*' '*libsolv*' '*hawkey*' 'yum*' 'curl')

RUN mkdir /workdir && \
    echo '<h1 style="text-align: center;"><span style="color: #000000;"><strong>Hello World</strong></span></h1>' > /var/www/html/index.html && \
    chmod 1001 /opt/app-root/src/

COPY --from=builder /usr/src/poc/target/log4j-rce-1.0-SNAPSHOT-jar-with-dependencies.jar /workdir

USER 1001
