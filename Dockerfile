FROM ubuntu:16.10

ARG APP_PATH
ARG APP_GROUP
ARG APP_USER
ARG RUBY_VERSION
ARG APP_GEMSET

RUN groupadd -f $APP_GROUP

RUN  if ! getent passwd $APP_USER > /dev/null 2>&1; then useradd -g $APP_GROUP  -s /bin/bash -b /home/ -m -d /home/$APP_USER $APP_USER; fi

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git-core curl zlib1g-dev libpq-dev  ca-certificates sudo dirmngr nodejs  build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3  curl git iputils-ping nginx-extras  libxml2-dev vim net-tools telnet wget libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs

RUN echo "$APP_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/01-$APP_USER

COPY files/install_rvm.sh /tmp/

RUN /tmp/install_rvm.sh $APP_USER $RUBY_VERSION $APP_GEMSET && rm /tmp/install_rvm.sh

#Remove any apt-get data
RUN  rm -rf /var/lib/apt/lists/*
