FROM centos:6.9

MAINTAINER Miguel Gila <miguel.gila@cscs.ch>
LABEL Description="This image is a WLCG User Interface using Docker" Vendor="CSCS" Version="20170717" URL="https://github.com/miguelgila/docker-wlcg_ui"

ADD http://repository.egi.eu/sw/production/cas/1/current/repo-files/EGI-trustanchors.repo /etc/yum.repos.d/

RUN rpm --import http://repository.egi.eu/sw/production/umd/UMD-RPM-PGP-KEY
RUN yum -y install epel-release yum-priorities
RUN yum -y install http://repository.egi.eu/sw/production/umd/4/sl6/x86_64/updates/umd-release-4.1.3-1.el6.noarch.rpm
# This goes after installing the UMD release
RUN yum -y update

# Now we get the grid stuff
RUN yum -y groupinstall 'Development Tools'
RUN yum -y install http://linuxsoft.cern.ch/wlcg/sl6/x86_64/wlcg-repo-1.0.0-1.el6.noarch.rpm
RUN yum -y install cvmfs ca-policy-egi-core iputils

RUN sed -i '/enabled=1/a\priority=10' /etc/yum.repos.d/epel.repo

## dteam VO ##
RUN mkdir -p /etc/grid-security/vomsdir/dteam
COPY etc/grid-security/vomsdir/dteam/voms2.hellasgrid.gr.lsc /etc/grid-security/vomsdir/dteam/voms2.hellasgrid.gr.lsc
COPY etc/grid-security/vomsdir/dteam/voms.hellasgrid.gr.lsc /etc/grid-security/vomsdir/dteam/voms.hellasgrid.gr.lsc
COPY etc/vomses/dteam-voms2.hellasgrid.gr  /etc/vomses/dteam-voms2.hellasgrid.gr
COPY etc/vomses/dteam-voms.hellasgrid.gr  /etc/vomses/dteam-voms.hellasgrid.gr

RUN yum install -y nordugrid-arc-arex nordugrid-arc-client emi-ui time which

#### DONE #####
