# Juicymo Drone CI Ruby image 

We use this image on a daily basis at [Juicymo](http://www.juicymo.cz) for Continuous Integration of Ruby on Rails apps we make for our clients.

[![](https://badge.imagelayers.io/juicymo/drone-ruby:latest.svg)](https://imagelayers.io/?images=juicymo/drone-ruby:latest 'Get your own badge on imagelayers.io')

## Installation

Compiled Docker image can be pulled from: [Docker Hub](https://hub.docker.com/r/juicymo/drone-ruby/).

![](http://dockeri.co/image/juicymo/drone-ruby)

## About

This is a Ruby image for [Drone](https://github.com/drone/drone) based on the [juicymo/drone-base](https://github.com/Juicymo/drone-base), inspired by [wingrunr21/drone-ruby](https://github.com/wingrunr21/drone-ruby).

Intent of this image is CI testing of Ruby or Rails projects with Drone.

This image has the following MRI rubies installed via chruby:

* 1.9.3-p551
* 2.0.0-p645
* 2.1.4
* 2.1.5
* 2.1.6
* 2.2.2

All rubies have [bundler](http://bundler.io/) installed.

If you need more ruby versions, let us know via GitHub issues or feel free to fork this Docker image or build a new one based on this one.

## Usage

Just add similar `.drone.yml` to you project:

```
TBD
```

At Juicymo, we use [GitLab](https://github.com/gitlabhq/gitlabhq) which is connected to our Drone CI server. With this setup Drone is able to detect all projects from GitLab automatically. After particular Ruby on Rails project is enabled for testing in Drone, all you need to do is to add, commit and push a `.drone.yml` to the git repository. Drone will automatically load it and start the integration.

See source at [GitHub](https://github.com/Juicymo/drone-ruby).