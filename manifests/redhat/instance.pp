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
define memcached::redhat::instance (
  $ensure=running,
  $port='11211',
  $user='memcached',
  $maxconn='1024',
  $cachesize='512',
  $options=undef
){
  include memcached::params

  if $title != 'default' {
    $instance_name = "-${title}"
  } else {
    $instance_name = ''
  }

  service { "memcached${instance_name}":
    ensure    => $ensure,
    hasstatus => true,
    require   => [
      Package['memcached'],
    ],
  }

  file { "${memcached::params::config}${instance_name}":
    ensure  => present,
    content => template('memcached/config.erb'),
    require => [
      Package['memcached'],
    ],
    notify  => Service["memcached${instance_name}"],
  }

  file { "${memcached::params::init}${instance_name}":
    ensure  => present,
    content => template('memcached/init.erb'),
    mode    => '0755',
    require => [
      Package['memcached'],
    ],
    notify  => Service["memcached${instance_name}"],
  }
}
