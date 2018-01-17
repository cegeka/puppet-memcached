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
define memcached::instance (
  $ensure=running,
  $enabled=undef,
  $listen='127.0.0.1',
  $port='11211',
  $user='memcached',
  $maxconn='1024',
  $cachesize='512',
  $options=undef
){
  case $::operatingsystem {
    'RedHat', 'CentOS': {
      memcached::redhat::instance { $name:
        ensure    => $ensure,
        enabled   => $enabled,
        listen    => $listen,
        port      => $port,
        user      => $user,
        maxconn   => $maxconn,
        cachesize => $cachesize,
        options   => $options,
      }
    }
    default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }
}
