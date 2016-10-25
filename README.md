[![Puppet Forge](http://img.shields.io/puppetforge/v/evenup/lita.svg)](https://forge.puppetlabs.com/evenup/lita)
[![Build Status](https://travis-ci.org/evenup/evenup-lita.png?branch=master)](https://travis-ci.org/evenup/evenup-lita)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What lita affects](#what-lita-affects)
    * [Beginning with lita](#beginning-with-lita)
4. [Usage](#usage)
5. [Reference](#reference)
6. [Limitations](#limitations)
7. [Development](#development)
8. [Changelog/Contributors](#changelog-contributors)


## Overview

A Puppet module that installs and configures [Lita](http://lita.io) bots

## Module Description

[Lita](http://lita.io) is a Chatbot written in ruby supporting various chat services and handlers.  This puppet module will configure a system for Lita and configure one or multiple bots.

## Setup

### What lita affects

* (*optional*) Manage bundler and packages required to build lita gems
* Lita bots and associated services

### Beginning with lita

Installation of the lita module:

```
  puppet module install evenup-lita
```

## Usage

Insallation and creation of 'test bot' using the irc adapter

```puppet
      class { 'lita':
        bundler_binpath => '/usr/bin'
      }

      lita::bot { 'test bot':
        adapter        => ':irc',
        adapter_config => { 'server' => 'irc.freenode.net', 'channels' => ['#litabot'] }
      }
```


## Reference

### Public methods

#### Class: lita

Main class for setting bot global defaults and global configuration

#####`base_path`

String.  Path Lita bots should be installed in

Default: /opt/lita

#####`manage_bundler`

Boolean.  Should the bundler gem be managed by this module

Default: false

#####`bundler_package`

String.  Name of the package to install if managing the bundler gem

Default: bundler

#####`bundler_provider`

String.  Provider used to install the bundler gem if managed by this module

Default: gem

#####`bundler_binpath`

String.  Path to the bundler binary

Default: /bin

#####`extra_packages`

String/Array of Strings.  If needed, a list of packages to manage with this module to support gem building for bots

#####`version`

String.  Default version of lita to use for bots

Default: latest

#####`adapter`

String.  Default adapter to use for bots

Default: :shell

#####`adapter_config`

Hash.  Default adapter configuration to use for bots

Default: {}

Format: {'key' => 'value'}

#####`bot_name`

String.  Default name to use for bots

Default: lita

#####`gems`

Array of Strings.  Default gems to use for bots

Default: []

#####`mention_name`

String.  Default mention name to use for bots

Default: lita

#####`plugins`

String.  Default plugins to use for bots

Default: []

#####`plugin_config`

Hash.  Default plugin configuration to use for bots

Default: []

Format: { 'plugin_name' => { 'key' => 'value' } }

#####`admins`

Array of Strings.  Default list of admins to use for bots

Default: []

#####`locale`

String.  Default localeto use for bots

Default: en

#####`log_level`

String.  Default log_level to use for bots

Default: :info

#####`http_host`

String.  Default host to listen for HTTP requests on for bots

Default: '0.0.0.0'

#####`http_port`

Integer.  Default port to listen for HTTP requests on for bots

Default: 8080

#####`redis_host`

String.  Default redis host to use for bots

Default: '127.0.0.1'

#####`redis_port`

Integer.  Default redis port to use for bots

Default: 6379


#### Define: lita::bot

Configures individual lita bots.

#####`version`

String.  Version of lita to use

Default: latest

#####`adapter`

String.  Adapter to be used by this bot

Default: :shell

#####`adapter_config`

Hash.  Adapter configuration for this bot

Default: {}

Format: {'key' => 'value'}

#####`bot_name`

String.  Name to be used by the bot

Default: lita

#####`gems`

Array of Strings.  Gems needed for this bot

Default: []

#####`mention_name`

String.  Mention name for this bot

Default: lita

#####`plugins`

String.  Plugins to be used by this bot

Default: []

#####`plugin_config`

Hash.  Plugin configuration to be used by this bot

Default: []

Format: { 'plugin_name' => { 'key' => 'value' } }

#####`admins`

Array of Strings.  Admin names of this bot

Default: []

#####`locale`

String.  Locale to be used by this bot

Default: en

#####`log_level`

String.  Log_level for this bot

Default: :info

#####`http_host`

String.  Address to open listening port on for this bot

Default: '0.0.0.0'

#####`http_port`

Integer.  Port to listen on for this bot

Default: 8080

#####`redis_host`

String.  Redis host to use for this bot

Default: '127.0.0.1'

#####`redis_port`

Integer.  Port to connect to redis on

Default: 6379


### Private classes

* `lita::params`: Default lita configuration

## Limitations

* Only tested on RHEL/CentOS 7/Ubuntu 16.04

## Development

Improvements and bug fixes are greatly appreciated.  See the [contributing guide](https://github.com/evenup/evenup-lita/CONTRIBUTING.md) for
information on adding and validating tests for PRs.


## Changelog / Contributors

[Changelog](https://github.com/evenup/evenup-lita/blob/master/CHANGELOG)

[Contributors](https://github.com/evenup/evenup-lita/graphs/contributors)
