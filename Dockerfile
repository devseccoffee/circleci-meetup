FROM maven as builder

COPY . /usr/src/poc
WORKDIR /usr/src/poc
RUN mvn clean && mvn package

FROM registry.access.redhat.com/ubi8/ubi

RUN mkdir /workdir && dnf update -y && dnf -y clean all --enablerepo='*' && rpm -e --nodeps $(rpm -qa '*rpm*' '*dnf*' '*libsolv*' '*hawkey*' 'yum*' 'curl')

COPY --from=builder /usr/src/poc/target/log4j-rce-1.0-SNAPSHOT-jar-with-dependencies.jar /workdir

USER 1001
