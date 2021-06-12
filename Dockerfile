FROM ubuntu:20.04
LABEL maintainer="joshb@mesosphere.com" purpose="Josh's lab ubuntu image"
WORKDIR /
ENV TERM xterm
# next line is not yet verified
ENV JAVA_HOME /usr/lib/jvm/java-9-openjdk-amd64	
ENTRYPOINT bash 

RUN apt-get update
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
apt-utils apt-transport-https \
coreutils \
curl \
vim \
nano \
jq \
iputils-ping \
ca-certificates \
libc-bin \
net-tools \
traceroute \
netcat \
dnsutils \
tcpdump \
ftp \
openssh-client \
nmap python3-nmap \
dos2unix \
python3 python3-pip \
atop \
p7zip \
iperf \
findutils \
unzip \
zip \
bzip2 \
txt2regex

# mtr-tiny is an enhanced traceroute, use 'mtr' to launch 

# openjdk-9-jre-headless \ ca-certificates-java \ 
# wireshark
# -the k8s cli?

RUN pip3 install --upgrade pip
RUN pip3 install virtualenv

RUN apt-get clean

