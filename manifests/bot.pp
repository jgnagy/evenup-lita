# == Define: lita::bot
#
# Configures an individual lita bot
#
#
define lita::bot (
  $version          = $::lita::version,
  $adapter          = $::lita::adapter,
  $bot_name         = $::lita::name,
  $gems             = $::lita::gems,
  $mention_name     = $::lita::mention_name,
  $plugins          = $::lita::plugins,
  $plugin_config    = $::lita::plugin_config,
  $admins           = $::lita::admins,
  $locale           = $::lita::locale,
  $log_level        = $::lita::log_level,
  $adapter_config   = $::lita::adapter_config,
  $http_host        = $::lita::http_host,
  $http_port        = $::lita::http_port,
  $redis_host       = $::lita::redis_host,
  $redis_port       = $::lita::redis_port,
) {

  if !defined(Class['lita']) {
    fail('You must include the lita base class before configuring a bot')
  }

  $_name = regsubst($name, '[\.\s&]', '_', 'G')
  $bot_dir = "${::lita::base_path}/${_name}"

  file { $bot_dir:
    ensure => 'directory',
    owner  => 'lita',
    group  => 'lita',
  }

  file { "${bot_dir}/Gemfile":
    owner   => 'lita',
    group   => 'lita',
    content => template('lita/Gemfile.erb'),
    notify  => Exec["bundle_install_${_name}"],
  }

  file { "${bot_dir}/lita_config.rb":
    owner   => 'lita',
    group   => 'lita',
    mode    => '0440',
    content => template('lita/lita_config.rb.erb'),
    notify  => Service["lita_${_name}"],
  }

  exec { "bundle_install_${_name}":
    command     => "${::lita::bundler_binpath}/bundle install --path vendor/bundle",
    cwd         => $bot_dir,
    user        => 'lita',
    refreshonly => true,
    notify      => Service["lita_${_name}"],
  }

  file { "${::lita::service_path}/lita@${_name}.service.d":
    ensure  => 'directory',
  }

  file { "${::lita::service_path}/lita@${_name}.service.d/workingdir.conf":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0444',
    content => "[Service]\nWorkingDirectory=${bot_dir}\n",
  }

  file { "${::lita::service_env_file}-${_name}":
    ensure  => file,
    content => "HOME=${bot_dir}\n",
  }

  service { "lita_${_name}":
    ensure => running,
    name   => "lita@${_name}",
    enable => true,
  }

}
