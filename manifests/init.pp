# Class: rbenv
#

class rbenv (
  $global_version = undef
) {
  package { ['build-essential', 'rbenv']:
    ensure => 'installed',
  }

  exec { 'rbenv:rehash':
    command     => '/usr/bin/rbenv rehash || true', # may be return 1
    environment => 'RBENV_ROOT=/usr/lib/rbenv',
    refreshonly => true,
  }

  file{ '/etc/gemrc':
    content => "gem: --no-ri --no-rdoc\n"
  }

  if $global_version != undef {
    file{ '/usr/lib/rbenv/version':
      ensure  => 'present',
      content => $global_version,
      require => Rbenv::Ruby[$global_version],
    }
  }
}
