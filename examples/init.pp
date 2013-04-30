include memcached

memcached::instance { '11211':
  ensure    => running,
  port      => '11211',
  user      => 'memcached',
  maxconn   => '1024',
  cachesize => '512',
  options   => '',
}
