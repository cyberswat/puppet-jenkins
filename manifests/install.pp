# Class: jenkins::install
#
# This class installs jenkins
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class jenkins::install inherits jenkins::params {

  # Use a key folder for managing keys
  file { $jenkins::params::jenkins_key_directory:
    ensure => "directory",
    mode    => 644,
    owner   => root,
    group   => root,
  }

  # Download the jenkins key
  exec { "wget http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key && apt-key add ${jenkins::params::jenkins_key_directory}/jenkins-ci.org.key":
    cwd => $jenkins::params::jenkins_key_directory,
    creates => "${jenkins::params::jenkins_key_directory}/jenkins-ci.org.key",
    path => ["/usr/bin", "/usr/sbin"]
  }

  # Add the jenkins repository and update apt-get
  exec { "echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list && apt-get update":
    cwd => $jenkins::params::jenkins_key_directory,
    creates => "/etc/apt/sources.list.d/jenkins.list",
    path => ["/bin", "/usr/bin"]
  }

  package { $jenkins::params::jenkins_server_package:
    ensure => present,
  }

  service { $jenkins::params::jenkins_server_service:
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    enable => true,
  }
}

