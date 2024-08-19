class memcached::params {

  case $facts['os']['name'] {
    'RedHat','CentOS': {
      $config = '/etc/sysconfig/memcached'
      $init = '/etc/init.d/memcached'
    }
    default: {
      notice ('Operating system not yet implemented')
    }
  }
}
