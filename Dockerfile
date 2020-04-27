FROM quay.io/openshift/origin-jenkins-agent-maven:4.6

USER root

# curl https://copr.fedorainfracloud.org/coprs/alsadi/dumb-init/repo/epel-7/alsadi-dumb-init-epel-7.repo -o /etc/yum.repos.d/alsadi-dumb-init-epel-7.repo && \ 
RUN  curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \
  curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
 # curl http://mirror.centos.org/centos-8/8/os/x86_64/RPM-GPG-KEY-CentOS-Official -o /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial && \
  DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl --disablerepo=rhel-fast-datapath-beta --disablerepo=rhel-fast-datapath" && \
  yum $DISABLES -y --setopt=tsflags=nodocs update && \
  yum $DISABLES -y --setopt=tsflags=nodocs install wget && \
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
  yum $DISABLES -y install ./google-chrome-stable_current_x86_64.rpm && \
  #wget http://mirror.centos.org/centos/7/updates/x86_64/Packages/java-11-openjdk-11.0.4.11-1.el7_7.x86_64.rpm && \
  #yum $DISABLES --disableplugin=subscription-manager -y install ./java-11-openjdk-11.0.4.11-1.el7_7.x86_64.rpm && \
  #yum $DISABLES -y install java-11-openjdk-devel && \
  alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.7.10-4.el7_8.x86_64/bin/java
 # wget http://mirror.centos.org/centos/7/os/x86_64/Packages/maven-local-3.4.1-11.el7.noarch.rpm && \
 # yum $DISABLES --disableplugin=subscription-manager -y install ./maven-local-3.4.1-11.el7.noarch.rpm
    
# for main web interface:
#EXPOSE 8080

USER 1001

#ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.4.11-1.el7_7.x86_64/bin/java
RUN google-chrome --version
RUN java -version
#RUN mvn -version
#FROM quay.io/openshift/jenkins-agent-maven-35-centos7:v4.0 - unauthorized: access to the requested resource is not authorized
#FROM quay.io/openshift/origin-jenkins-agent-maven:4.1.0
