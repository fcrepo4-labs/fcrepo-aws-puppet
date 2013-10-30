# = Class: tomcat7
# 
# This class installs/configures/manages the Tomcat v7 Java application server.
# Only supported on Debian-derived OSes.
# 
# == Parameters: 
#
# $enable::     Whether to start the Tomcat service on boot. Defaults to
#               true. Valid values: true and false. 
# $ensure::     Whether to run the Tomcat service. Defaults to running.
#               Valid values: running and stopped. 
# $http_port::  Port to configure the HTTP connector with. Defaults to 8080.
# $https_port:: Port to configure the HTTPS connector with. Defaults to 8443.
# $jre::        JRE package to depend on. Defaults to 'default'. Suggested
#               values: 'openjdk-6', 'openjdk-7', 'sun-java6', 'oracle-java7'
# $install_admin:: Whether to install the tomcat7-admin package. Defaults to
#                  true. Valid values: true and false.
# 
# == Requires: 
# 
# Nothing.
# 
# == Sample Usage:
#
#   class {'tomcat7':
#     http_port => 80,
#     jre => 'openjdk-7',
#   }
#   class {'tomcat7':
#     enable => false,
#     ensure => stopped,
#   }
#



class tomcat7 (
    $enable = true,
    $ensure = running,
    $http_port = 8080,
    $https_port = 8443,
    $jre = 'default',
    $install_admin = true,
    $data_dir = '/opt/fcrepo4-data',
    $repo_config = 'classpath:/config/async-indexing/repository.json',
#    $repo_config = 'classpath:/config/clustered/repository.json',
    $etc_default_tomcat = 'tomcat7/default-tomcat7.erb',
#    $etc_default_tomcat = 'tomcat7/default-tomcat7-clustered.erb',
    $install_yourkit = false, 
) {

  if ($install_yourkit) {
    include yourkit
    $yourkitdir = "$yourkit::yourkit"
  }

  $jre_package = "${jre}-jre-headless"
  $private_ip = "${ip_address}"

  notify {"$ip_address":}

  exec { "increase send buffer size":
    command => "sudo sysctl -w net.core.rmem_max=5242880",
    path => "/bin/:/usr/bin/",
  }

  exec { "increase recv buffer size":
    command => "sudo sysctl -w net.core.wmem_max=5242880",
    path => "/bin/:/usr/bin/",
  }

  package { 'tomcat7':
    ensure => installed,
    require => Package[$jre_package],
  }

  if ($install_admin) {
    package { 'tomcat7-admin':
      ensure => installed,
      require => Package['tomcat7'],
    }
  }

  package { $jre_package:
  }

  file { '/etc/tomcat7/server.xml':
     owner => 'root',
     content => template('tomcat7/server.xml.erb'),
     notify => Service['tomcat7'],
     require => Package['tomcat7'],
  }

  file { $data_dir:
    owner => 'root',
    group => 'tomcat7',
    mode => '0774',
    ensure => 'directory',
    require => Package['tomcat7'],
  }

  file { '/etc/default/tomcat7':
     owner => 'root',
     content => template("${etc_default_tomcat}"),
     notify => Service['tomcat7'],
     require => Package['tomcat7'],
  }
 
  if ($install_yourkit) {
    
    service { 'tomcat7':
      ensure => $ensure,
      enable => $enable,
      require => [Package['tomcat7'],
        File[$data_dir],
        File['/etc/default/tomcat7'],
        Exec['untar yourkit'],
      ],
    }

  } 
  else {

    service { 'tomcat7':
      ensure => $ensure,
      enable => $enable,
      require => [Package['tomcat7'],
        File[$data_dir],
        File['/etc/default/tomcat7'],
      ],
    }

  }

}
