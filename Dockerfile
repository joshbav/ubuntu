# This is not intended to be a small container image.
# It's used to develop a working image, then a new Dockerfile is made
# with just what's needed.

FROM ubuntu:20.04
WORKDIR /

COPY .vimrc /etc/vim/vimrc

RUN cp /etc/bash.bashrc /root/.bashrc
RUN echo "alias ls='ls -ltrGFha --color=auto'" >> /root/.bashrc

ENV TERM xterm
ENV DEBIAN_FRONTEND=noninteractive

#### BASE APT UPDATE AND INSTALLS
RUN echo;echo
RUN echo "Running base apt update and installs"
RUN apt-get update
RUN apt-get install -y apt-utils ca-certificates locales
RUN echo;echo

#### LOCALE - Sometimes my images are used in other countries
# RUN apt-get install -y language-pack-??
# Note as of 8-21 LANG=C breaks python3
RUN echo "Running locale install and configure"
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN locale-gen en_US.UTF-8
RUN update-locale en_US.UTF-8
# Timezone
ENV TZ America/Los_Angeles
RUN rm -f /etc/localtime
RUN ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
RUN echo;echo
#### END LANGUAGE

#### JOSH'S BASE UTILITIES
RUN echo "Running base utilities install"
RUN apt-get install -y \
atop \
bash-completion \
bzip2 \
coreutils \
curl \
dnsutils \
expect \
findutils \
ftp \
git \
iperf \
iputils-ping \
jq \
less \
libc-bin \
man-db \
nano \
net-tools \
netcat \
nfs-common \
nmap \
openssh-client \
p7zip \
rsync \
tcptraceroute \
traceroute \
txt2regex \
unzip \
wget \
zip

RUN echo;echo
#### END JOSH'S BASE UTILITIES
# omitted: vim tcpdump dos2unix
# mtr-tiny is an enhanced traceroute, use 'mtr' to launch 
# wireshark

#### UNMINIMIZE, for man command, etc. Takes about 10MB
# yes is already installed in ubuntu
RUN yes|unminimize
#### END UNMINIMIZE

#### KUBERNETES CLI
#RUN echo "Installing kubectl"
# Per: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management
#curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
#echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
#apt-get install -y kubectl
#kubectl version --short
#RUN echo;echo
#### END KUBERNETES CLI

#### PYTHON 3.9 - AS OF 8-2021
#RUN RUN echo "Installing Python 3"
#RUN apt-get remove -y python3
#RUN apt-get autoremove -y
#RUN apt-get install -y python3.9 python3.9-venv python3.9-doc binutils python3-pip binutils-doc cpp-doc gcc-9-locales gcc-9-doc
#### LIKELY UNNECESSARY# RUN apt-get install -y build-essential
#RUN python3 -m pip install --upgrade pip
#RUN # don't do with ubuntu # pip3 install --upgrade pip
#RUN pip install mypy scipy numpy pandas requests 
#RUN echo;echo
#### END PYTHON 3

#### JAVA
#RUN echo "Installing Java 11"
# JVM ONLY: openjdk-11-jre-headless
#RUN apt-get install -y openjdk-11-jdk-headless ca-certificates-java
#RUN java -version
#ENV JAVA_HOME /usr/bin
##ENV JAVA_VERSION 11.0.5
#RUN echo;echo
#### END JAVA

#### GO
#RUN echo "Installing latest golang"
#RUN apt-get install -y golang
#### LIKELY UNNECESSARY# RUN apt-get install -y build-essential
#RUN go version
RUN echo;echo
#### END GO

RUN apt-get clean

ENTRYPOINT bash

RUN echo "This container image was built on:" > /docker_build.txt
RUN echo $(date) >> /docker_build.txt
