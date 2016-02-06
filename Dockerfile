# see https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/ for Dockerfile best practices

# build me with:
# docker build -t "juicymo/drone-ruby:1.0.0" .

FROM juicymo/drone-base
MAINTAINER Tomas Jukin <tomas.jukin@juicymo.cz>

# setup environment
ENV SHELL /bin/bash
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update

# install rubies
RUN ruby-install ruby 1.9.3-p551
RUN ruby-install ruby 2.0.0-p645
RUN ruby-install ruby 2.1.4
RUN ruby-install ruby 2.1.5
RUN ruby-install ruby 2.1.6
RUN ruby-install ruby 2.2.2

# install bundler for each ruby
RUN /bin/bash -l -c "chruby 1.9.3 && gem install bundler --no-rdoc --no-ri"
RUN /bin/bash -l -c "chruby 2.0.0 && gem install bundler --no-rdoc --no-ri"
RUN /bin/bash -l -c "chruby 2.1.4 && gem install bundler --no-rdoc --no-ri"
RUN /bin/bash -l -c "chruby 2.1.5 && gem install bundler --no-rdoc --no-ri"
RUN /bin/bash -l -c "chruby 2.1.6 && gem install bundler --no-rdoc --no-ri"
RUN /bin/bash -l -c "chruby 2.2.2 && gem install bundler --no-rdoc --no-ri"
