FROM registry.access.redhat.com/ubi8/ubi

RUN dnf update -y && dnf -y clean all --enablerepo='*' && \
    rpm -e --nodeps $(rpm -qa '*rpm*' '*dnf*' '*libsolv*' '*hawkey*' 'yum*' 'curl')

USER 1001
