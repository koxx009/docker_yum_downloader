FROM oraclelinux:7.8

ARG PACKAGES

ADD ./repos.d/*.repo /etc/yum.repos.d/

RUN yum-config-manager --enable ol7_latest,ol7_optional_latest,ol7_addons,ol7_software_collections,ol7_developer_EPEL
RUN yum install python python-pip -y
RUN pip install ansible==2.10.0

ADD ./yum-download.yml /yum-download.yml
CMD ansible-playbook --connection=local /yum-download.yml --extra-vars "{packages: [${PACKAGES}]}"
