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

RUN apt-get update
RUN apt-get upgrade -y
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get install -y apt-utils ca-certificates
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

# omitted: tcpdump dos2unix
# mtr-tiny is an enhanced traceroute, use 'mtr' to launch 
# wireshark

#### KUBERNETES CLI
# Per: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management
#curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

#echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

#apt install -y kubectl
#kubectl version --short
#### END KUBERNETES CLI

#### PYTHON 3 - AS OF 8-2021
#RUN apt install -y python3.9-full python3.9-venv
#RUN pip3 install --upgrade pip
#### END PYTHON 3

#### JAVA
#RUN apt install -y openjdk-11-jre-headless ca-certificates-java
#RUN java -version
#ENV JAVA_VERSION 11.0.5
#### END JAVA

RUN apt-get clean

ENTRYPOINT bash
