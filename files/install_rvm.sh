#!/bin/bash

function try_command {
  n=0
  until [ $n -ge 5 ]
  do
     eval $1 && return 0
     n=$[$n+1]
     sleep 15
  done
  exit 1
}

try_command  "su - $APP_USER -c gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
try_command  "su - $APP_USER -c 'curl -sSL https://get.rvm.io | bash -s stable'"
try_command  "su - $APP_USER -c rvm install $RUBY_VERSION"
try_command  "su - $APP_USER -c rvm use $RUBY_VERSION --default"
try_command  "su - $APP_USER -c rvm gemset create $APP_GEMSET"
try_command  "su - $APP_USER -c rvm gemset use  $APP_GEMSET && gem install bundler"
