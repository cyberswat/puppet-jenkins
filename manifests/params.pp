# Class: jenkins::params
#
# This class manages os specific parameters
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
class jenkins::params {
  case $operatingsystem {
    /(Ubuntu)/: {
      $jenkins_server_package = "jenkins"
      $jenkins_key_directory = "/root/.keys"
      $jenkins_server_service = "jenkins"
    }
  }
}
