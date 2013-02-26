# Resource: rbenv::ruby
#
# Parameters:
#   [*version*]     - a ruby version
#
# Actions:
#

define rbenv::ruby (
  $version = $title,
){
  include 'rbenv'

  $ruby_package = "rbenv-${version}"

  package{ $ruby_package:
    ensure  => 'present',
    require => [Package['rbenv'], File['/etc/gemrc']]
  }

  $gem_path = "/usr/lib/rbenv/versions/${version}/bin/gem"

  exec{ "rbenv:bundler_${version}":
    command => "${gem_path} install bundler",
    unless  => "${gem_path} list | grep bundler",
    require => Package[$ruby_package],
    notify  => Exec['rbenv:rehash']
  }
}
