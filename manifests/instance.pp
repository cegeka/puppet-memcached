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
  $port='11211',
  $user='memcached',
  $maxconn='1024',
  $cachesize='512',
  $options=undef
){
  case $::operatingsystem {
    redhat, centos: {
      memcached::redhat::instance { $name:
        ensure    => $ensure,
        enabled   => $enabled,
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
