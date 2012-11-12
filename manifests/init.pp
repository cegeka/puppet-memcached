# Class: memcached
#
# This module manages memcached
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class memcached (
  $ensure=running,
  $port='11211',
  $user='memcached',
  $maxconn='1024',
  $cachesize='512',
  $options=undef
){

  include memcached::params

  package { 'memcached':
    ensure => installed,
  }

  service { 'memcached':
    ensure  => $ensure,
    require => [Package['memcached'],File[$memcached::params::config]],
  }

  file { $memcached::params::config :
    ensure  => present,
    content => template('memcached/config.erb'),
    require => Package['memcached'],
    notify  => Service['memcached'],
  }
}
