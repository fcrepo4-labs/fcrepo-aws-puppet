define tomcat7::webapp($path) {

  include tomcat7

  file { "/var/lib/tomcat7/webapps/${name}.war":
    owner => 'root',
    source => $path,
  }

}
