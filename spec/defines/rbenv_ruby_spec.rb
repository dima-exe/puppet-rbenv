require 'spec_helper'

describe "rbenv::ruby" do
  let(:title) { 'my-ruby-version' }

  it { should include_class("rbenv::config") }

  it do should contain_package("rbenv-my-ruby-version").with(
    :ensure  => 'present',
    :require => %w{ Package[rbenv] File[/etc/gemrc] }
  ) end

  it do should contain_exec("rbenv:my-ruby-version bundler").with(
    :command => "/usr/bin/env RBENV_VERSION=my-ruby-version rbenv exec gem install bundler --version='=1.3.4'",
    :unless  => "/usr/bin/env RBENV_VERSION=my-ruby-version rbenv exec gem query -i -n 'bundler' -v '1.3.4'",
    :require => 'Package[rbenv-my-ruby-version]',
    :notify  => 'Exec[rbenv:rehash]'
  ) end
end
