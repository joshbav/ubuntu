FROM ubuntu:20.04
WORKDIR /

ENV TERM xterm

#### LANGUAGE
# Default to UTF-8 file.encoding
ENV LANG en_US.UTF-8
# Needed by Python 3 for some reason
#ENV LANG C.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
#### END LANGUAGE


###ENV JAVA_HOME /usr/lib/jvm/java-9-openjdk-amd64

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y apt-utils ca-certificates locales

#### LOCALE - Sometimes my images are used in other countries
# RUN apt-get install -y language-pack-??
# Note as of 8-21 LANG=C breaks python3
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN locale-gen en_US.UTF-8
#### END LANGUAGE

#### JOSH'S BASE UTILITIES
RUN apt-get install -y \
atop \
bzip2 \
coreutils \
curl \
dnsutils \
findutils \
ftp \
iperf \
iputils-ping \
jq \
less \
libc-bin \
locales \
nano \
net-tools \
netcat \
nmap \
openssh-client \
p7zip \
traceroute \
txt2regex \
unzip \
vim \
zip

#### END JOSH'S BASE UTILITIES

# omitted: tcpdump dos2unix
# mtr-tiny is an enhanced traceroute, use 'mtr' to launch 
# wireshark

#### KUBERNETES CLI
# Per: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management
#curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

#echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

#apt-get install -y kubectl
#kubectl version --short
#### END KUBERNETES CLI

#### PYTHON 3 - AS OF 8-2021
#RUN apt-get install -y python3.9 python3.9-venv
#RUN apt-get install -y pythgon3-pip
#RUN # don't do with ubuntu # pip3 install --upgrade pip
#### END PYTHON 3

#### JAVA
#RUN apt-get install -y openjdk-11-jre-headless ca-certificates-java
#RUN java -version
#ENV JAVA_HOME /usr/bin
##ENV JAVA_VERSION 11.0.5
#### END JAVA

#### GO
#RUN apt-get install -y golang
#RUN go version
#### END GO 
RUN apt-get clean

ENTRYPOINT bash
