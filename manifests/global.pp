#
class rbenv::global(
  $version = undef
) {

  if $version != undef {
    file{ '/usr/lib/rbenv/version':
      ensure  => 'present',
      content => $version,
      require => Rbenv::Ruby[$version],
    }
  }
}
