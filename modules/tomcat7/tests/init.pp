node default {

   class { 'tomcat7':
      jre => 'openjdk-7',
   }

  tomcat7::fcrepo-webapp { "fcrepo webapp":
    url => 'http://ci.fcrepo.org/jenkins/job/fcrepo4/lastSuccessfulBuild/org.fcrepo$fcrepo-webapp/artifact/org.fcrepo/fcrepo-webapp/4.0-SNAPSHOT/fcrepo-webapp-4.0-SNAPSHOT.war',
    war => 'fcrepo.war',
  }

}
