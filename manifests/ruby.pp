# Resource: rbenv::ruby
#
# Parameters:
#   [*version*]     - a ruby version
#
# Actions:
#

define rbenv::ruby (
  $version         = $title,
  $ensure          = 'present',
){
  include 'rbenv::config'

  $ruby_package    = "rbenv-${version}"
  $bundler_version = $rbenv::config::bundler_version

  package{ $ruby_package:
    ensure  => $ensure,
    require => [Package['rbenv'], File['/etc/gemrc']]
  }

  if $ensure == 'present' {
    $gem_path = "/usr/lib/rbenv/versions/${version}/bin/gem"

    exec{ "rbenv:${version} bundler":
      command => "${gem_path} install bundler --version='=${bundler_version}'",
      unless  => "${gem_path} query -i -n 'bundler' -v '${bundler_version}'",
      require => Package[$ruby_package],
      notify  => Exec['rbenv:rehash']
    }
  }
}
