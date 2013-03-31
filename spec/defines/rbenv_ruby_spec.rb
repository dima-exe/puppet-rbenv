require 'spec_helper'

describe "rbenv::ruby" do
  let(:title) { 'my-ruby-version' }

  it { should include_class("rbenv::config") }

  it do should contain_package("rbenv-my-ruby-version").with(
    :ensure  => 'present',
    :require => %w{ Package[rbenv] File[/etc/gemrc] }
  ) end

  it do should contain_exec("rbenv:my-ruby-version bundler").with(
    :command => "/usr/lib/rbenv/versions/my-ruby-version/bin/gem install bundler --version='=1.3.4'",
    :unless  => "/usr/lib/rbenv/versions/my-ruby-version/bin/gem query -i -n 'bundler' -v '1.3.4'",
    :require => 'Package[rbenv-my-ruby-version]',
    :notify  => 'Exec[rbenv:rehash]'
  ) end
end
