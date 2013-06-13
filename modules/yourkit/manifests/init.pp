# = Class: yourkit
# 
# This class downloads and installs YourKit JVM profiler.
# 
# == Parameters: 
#
# $url::      URL base from whence to download yourkit.
# $yourkit::  Name of the YourKit package minus the extension
# 
# == Requires: 
# 
# Nothing.
# 
# == Sample Usage:
#
#   class {'yourkit':
#     url => 'http://www.yourkit.com/download',
#     yourkit => 'yjp-12.0.5',
#   }
#

class yourkit (
    $url = "http://www.yourkit.com/download",
    $yourkit = "yjp-12.0.5",
) {

  $yourkit_tar = "${yourkit}-linux.tar.bz2"
  $yourkit_tar_dest = "/opt/${yourkit_tar}"

  exec { 'download yourkit':
    command => "/usr/bin/wget ${url}/${yourkit_tar} -O ${yourkit_tar_dest}",
    creates => "${yourkit_tar_dest}",
  }

  exec { 'untar yourkit':
    command => "/bin/tar xfj ${yourkit_tar_dest}",
    cwd => "/opt",
    creates => "/opt/${yourkit}",
    require => Exec['download'],
  }

}
