node default {

   class { 'tomcat7':
      jre => 'openjdk-7',
   }

  tomcat7::fcrepo-webapp { "fcrepo webapp":
#    url => 'http://ci.fcrepo.org/jenkins/view/FF/job/fcrepo-kitchen-sink/lastSuccessfulBuild/artifact/target/fcrepo-kitchen-sink-4.0-SNAPSHOT.war',
    url => 'http://ci.fcrepo.org/jenkins/job/fcrepo-kitchen-sink/353/artifact/target/fcrepo-kitchen-sink-4.0-SNAPSHOT.war',
    war => 'fcrepo.war',
  }

}
