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
  $enabled=true,
  $listen='127.0.0.1',
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
    enable    => $enabled,
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

  case $::operatingsystemmajrelease {
    '7': {
      file { "/usr/lib/systemd/system/memcached${instance_name}.service":
        ensure  => present,
        content => template('memcached/systemd.erb'),
      }
      exec { "reload systemctl /usr/lib/systemd/system/memcached${instance_name}.service":
        command   => '/bin/systemctl daemon-reload',
        onlyif    => "/usr/bin/systemctl status memcached${instance_name} 2>&1 | /usr/bin/grep \"[c]hanged on disk\"",
        subscribe => File["/usr/lib/systemd/system/memcached${instance_name}.service"],
        notify    => Service["memcached${instance_name}"]
      }
    }
    '5','6': {
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
    default: {}
  }
}
