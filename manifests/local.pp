# ...
define rbenv::local (
  $version,
  $owner,
  $path = $title,
) {

  file { "${path}/.ruby-version":
    ensure  => 'present',
    content => $version,
    owner   => $owner,
    require => Rbenv::Ruby[$version]
  }
}
