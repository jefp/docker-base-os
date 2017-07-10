#!/bin/bash -x

export APP_USER=$1
export RUBY_VERSION=$2
export APP_GEMSET=$3

function try_command {
  n=0
  until [ $n -ge 5 ]
  do
     echo "executing su - $APP_USER -c '$1'"
     eval "su - $APP_USER -c '$1'" && return 0
     n=$[$n+1]
     sleep 15
  done
  exit 1
}

try_command  "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
try_command  "curl -sSL https://get.rvm.io | bash -s stable"
try_command  "rvm install $RUBY_VERSION"
try_command  "rvm use $RUBY_VERSION --default"
try_command  "rvm gemset create $APP_GEMSET"
try_command  "rvm gemset use  $APP_GEMSET && gem install bundler"
