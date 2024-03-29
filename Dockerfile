FROM maven as builder 

COPY . /usr/src/poc
WORKDIR /usr/src/poc
RUN mvn clean && mvn package

FROM registry.access.redhat.com/ubi8/httpd-24
USER root
RUN yum update -y 

USER 1001
COPY --from=builder /usr/src/poc/target/log4j-rce-1.0-SNAPSHOT-jar-with-dependencies.jar /opt/app-root/src/

ENTRYPOINT ["tail", "-f", "/dev/null"]
