# Juicymo Drone CI Ruby image 

We use this image on a daily basis at [Juicymo](https://www.juicymo.cz) for Continuous Integration of Ruby on Rails apps we make for our clients.

[![](https://images.microbadger.com/badges/image/juicymo/drone-ruby.svg)](https://microbadger.com/images/juicymo/drone-ruby "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/juicymo/drone-ruby.svg)](https://microbadger.com/images/juicymo/drone-ruby "Get your own version badge on microbadger.com")

## Installation

Compiled Docker image can be pulled from: [Docker Hub](https://hub.docker.com/r/juicymo/drone-ruby/).

![](http://dockeri.co/image/juicymo/drone-ruby)

## About

This is a Ruby image for [Drone](https://github.com/drone/drone), inspired by [413x/ruby-2.3.3-alpine](https://github.com/413x/ruby-2.3.3-alpine).

Intent of this image is CI testing of Ruby or Rails projects with Drone.

This image supports `Drone 0.7.0` and `MRI Ruby 2.4.2`:

It has a [bundler](http://bundler.io/) installed.

If you need more Ruby versions, let us know via GitHub issues or feel free to fork this Docker image or build a new one based on this one.

We use the [drillster/drone-volume-cache](https://github.com/drillster/drone-volume-cache) image to smartly cache the `./bundle` and `./node_modules` folders to have faster builds which consume less resources because only updated gems and npm packages are reinstalled.

## Usage

Just add similar `.drone.yml` to you project *(example is compatible with Drone 0.7.0)*:

```yaml
pipeline:
  restore-cache:
    image: drillster/drone-volume-cache
    restore: true
    mount:
      - ./bundle
      - ./node_modules
    volumes:
      - /tmp/cache:/cache

  build:
    image: juicymo/drone-ruby
    environment:
      - RAILS_ENV=test
    commands:
      - bundle install --path ./bundle --without production,development

  rebuild-cache:
    image: drillster/drone-volume-cache
    rebuild: true
    mount:
      - ./bundle
      - ./node_modules
    volumes:
    - /tmp/cache:/cache

  test:
    image: juicymo/drone-ruby
    environment:
      - RAILS_ENV=test
      - DB_HOST=database
    commands:
      - bundle install --path ./bundle --without production,development
      - bundle exec rake db:create
      - bundle exec rake db:migrate
      - bundle exec rspec
      - bundle exec rake spinach

  notify:
    image: plugins/slack
    webhook: https://team.slack.com/hooks/XXX...
    channel: dev
    username: drone
    when:
      status: [ success, failure ]

services:
  database:
    image: postgres:9.6
    environment:
      - POSTGRES_USER=...
      - POSTGRES_PASSWORD=...
```

The example `drone.yml` file above shows how [RSpec](http://rspec.info/) and [Spinach](http://codegram.github.io/spinach/) can be used for BDD Testing in a Ruby on Rails application. This is what we use at [Juicymo](https://www.juicymo.cz), but feel free to adjust the `test` step of a pipeline to suit your needs.

At [Juicymo](https://www.juicymo.cz), we use [GitLab](https://github.com/gitlabhq/gitlabhq) which is connected to our Drone CI server. With this setup Drone is able to detect all projects from GitLab automatically. After particular Ruby on Rails project is enabled for testing in Drone, all you need to do is to add, commit and push a `.drone.yml` to the git repository. Drone will automatically load it and start the integration.

See source at [GitHub](https://github.com/Juicymo/drone-ruby).