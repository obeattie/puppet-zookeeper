class zookeeper {
  include zookeeper::config
  include homebrew

  file { [
    $zookeeper::config::configdir,
    $zookeeper::config::datadir,
    $zookeeper::config::logdir
  ]:
    ensure => directory,
  }

  homebrew::formula { 'zookeeper':
    source => 'puppet:///modules/zookeeper/brews/zookeeper.rb',
    before => Package['boxen/brews/zookeeper'] ;
  }

  package { 'boxen/brews/zookeeper':
    ensure  => '3.4.5-boxen1',
  }

  # Config Files

  file { "${zookeeper::config::configdir}/zoo.cfg":
    content => template('zookeeper/zoo.cfg'),
    require => File[$zookeeper::config::configdir],
  }

  file { "${zookeeper::config::configdir}/defaults":
    content => template('zookeeper/defaults'),
    require => File[$zookeeper::config::configdir],
  }

  file { "${zookeeper::config::configdir}/default_log4j_properties":
    content => template('zookeeper/default_log4j_properties'),
    require => File[$zookeeper::config::configdir],
  }

}