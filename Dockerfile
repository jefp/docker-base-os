FROM ubuntu:16.10

ARG APP_PATH
ARG APP_GROUP
ARG APP_USER
ARG RUBY_VERSION
ARG APPGEMSET

RUN groupadd -f $APP_GROUP

RUN  if ! getent passwd $APP_USER > /dev/null 2>&1; then useradd -g $APP_GROUP $APP_USER -s /bin/bash ; fi

RUN apt-get update && apt-get upgrade -y && apt-get install -y libpq-dev ssmtp ca-certificates sudo dirmngr nodejs libcurl3 curl git iputils-ping nginx-extras vim net-tools telnet wget

RUN echo "APP_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/01-$APP_USER

COPY files/install_rvm.sh /tmp/

RUN /tmp/install_rvm.sh $APP_USER $RUBY_VERSION $APP_GEMSET && rm /tmp/install_rvm.sh

#Remove any apt-get data
RUN  rm -rf /var/lib/apt/lists/*
