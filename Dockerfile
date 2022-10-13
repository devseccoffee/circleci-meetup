FROM maven:3.8.6-openjdk-18 as builder 

COPY . /usr/src/poc
WORKDIR /usr/src/poc
RUN mvn clean && mvn package

FROM registry.access.redhat.com/ubi8/ubi

RUN mkdir /workdir

COPY --from=builder /usr/src/poc/target/log4j-rce-1.0-SNAPSHOT-jar-with-dependencies.jar /workdir
