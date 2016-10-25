# == Class: lita::params
#
# Sets the default parameters for lita
#
#
class lita::params {
  # class
  $base_path = '/opt/lita'
  $manage_bundler = false
  $bundler_package = 'bundler'
  $bundler_provider = 'gem'

  $extra_packages = []
  case $::osfamily {
    'Debian': {
      $service_env_file = '/etc/default/lita'
      $service_path     = '/lib/systemd/system'
      $bundler_binpath  = '/usr/local/bin'
    }

    'RedHat': {
      $service_env_file = '/etc/sysconfig/lita'
      $service_path     = '/usr/lib/systemd/system'
      $bundler_binpath  = '/bin'
    }

    default: {
      fail "Operating system ${::operatingsystem} is not supported yet."
    }
  }

  # bot
  $version = 'latest'
  $adapter = 'shell'
  $adapter_config = {}
  $gems = []
  $plugins = []
  $plugin_config = {}
  $bot_name = 'Lita'
  $locale = 'en'
  $log_level = 'info'
  $admins = []
  $http_host = '0.0.0.0'
  $http_port = 8080
  $redis_host = '127.0.0.1'
  $redis_port = 6379
}
