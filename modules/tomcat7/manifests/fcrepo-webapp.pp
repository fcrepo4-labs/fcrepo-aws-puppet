define tomcat7::fcrepo-webapp($url,$war) {

  include tomcat7

  # Get war
  exec { 'download':
    command => "/usr/bin/wget $url -O /tmp/${war}",
    creates => "/tmp/${war}",
  }

  # Deploy war
  file { "/var/lib/tomcat7/webapps/${war}":
    owner => 'root',
    source => "/tmp/${war}",
    require => [Exec['download'],
      Package['tomcat7'],
      File['/etc/default/tomcat7'],
    ],
  }

}
