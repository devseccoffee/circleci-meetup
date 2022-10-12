FROM registry.access.redhat.com/ubi8/ubi

RUN mkdir /workdir && dnf update -y && dnf -y clean all --enablerepo='*'
RUN rpm -e --nodeps $(rpm -qa '*rpm*' '*dnf*' '*libsolv*' '*hawkey*' 'yum*' 'curl')

#COPY log4j-rce-1.0-SNAPSHOT-jar-with-dependencies.jar /workdir

USER 1001
