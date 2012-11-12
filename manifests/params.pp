class memcached::params {

  case $::operatingsystem {
    RedHat,CentOS: {
      $config = '/etc/sysconfig/memcached'
    }
    default: {
      notice ('Operating system not yet implemented')
    }
  }
}
