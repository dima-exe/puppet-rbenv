# Class: rbenv
#

class rbenv (
  $ruby           = undef,
  $global_version = undef
) {

  include 'rbenv::config'

  package { 'rbenv':
    ensure => $rbenv::config::rbenv_version,
  }

  package { 'build-essential':
    ensure => 'present'
  }

  exec { 'rbenv:rehash':
    command     => '/usr/bin/rbenv rehash || true', # may be return 1
    environment => 'RBENV_ROOT=/usr/lib/rbenv',
    refreshonly => true,
  }

  file{ '/etc/gemrc':
    content => "gem: --no-ri --no-rdoc\n"
  }

  if $ruby != undef {
    rbenv::ruby{ $ruby: }

    if $global_version == undef {
      if is_array($ruby) {
        class{ 'rbenv::global':
          version => $ruby[0]
        }
      } else {
        class{ 'rbenv::global':
          version => $ruby
        }
      }
    } else {
      class{ 'rbenv::global':
        version => $global_version
      }
    }
  }
}
