# == Class: lita
#
# Manages lita bots
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class lita (
  $base_path        = $::lita::params::base_path,
  $manage_bundler   = $::lita::params::manage_bundler,
  $bundler_package  = $::lita::params::bundler_package,
  $bundler_provider = $::lita::params::bundler_provider,
  $bundler_binpath  = $::lita::params::bundler_binpath,
  $extra_packages   = $::lita::params::extra_packages,
  $service_env_file = $::lita::params::service_env_file,
  $service_path     = $::lita::params::service_path,

  # bot defaults
  $version          = $::lita::params::version,
  $adapter          = $::lita::params::adapter,
  $adapter_config   = $::lita::params::adapter_config,
  $bot_name         = $::lita::params::name,
  $gems             = $::lita::params::gems,
  $mention_name     = $bot_name,
  $plugins          = $::lita::params::plugins,
  $plugin_config    = $::lita::params::plugin_config,
  $admins           = $::lita::params::admins,
  $locale           = $::lita::params::locale,
  $log_level        = $::lita::params::log_level,
  $http_host        = $::lita::params::http_host,
  $http_port        = $::lita::params::http_port,
  $redis_host       = $::lita::params::redis_host,
  $redis_port       = $::lita::params::redis_port,
) inherits lita::params {

  include ::systemd

  user { 'lita':
    ensure  => 'present',
    system  => true,
    gid     => 'lita',
    home    => $base_path,
    shell   => '/bin/bash',
    require => Group['lita'],
  }

  group { 'lita':
    ensure => 'present',
    system => true,
  }

  if $manage_bundler {
    package { $bundler_package:
      ensure   => 'installed',
      provider => $bundler_provider,
    }
  }

  package { $extra_packages:
    ensure => 'installed',
  }

  file { $base_path:
    ensure => 'directory',
    owner  => 'lita',
    group  => 'lita',
  }

  file { "${service_path}/lita@.service":
    owner   => root,
    group   => root,
    mode    => '0555',
    content => template('lita/lita.service.erb'),
    notify  => Exec['systemctl-daemon-reload'],
  }

}
