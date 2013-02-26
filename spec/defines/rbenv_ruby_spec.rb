require 'spec_helper'

describe "rbenv::ruby" do
  let(:title) { 'my-ruby-version' }

  it { should include_class("rbenv") }

  it do should contain_package("rbenv-my-ruby-version").with(
    :require => %w{ Package[rbenv] File[/etc/gemrc] }
  ) end

  it do should contain_exec("rbenv:bundler_my-ruby-version").with(
    :command => '/usr/lib/rbenv/versions/my-ruby-version/bin/gem install bundler',
    :unless  => '/usr/lib/rbenv/versions/my-ruby-version/bin/gem list | grep bundler',
    :require => 'Package[rbenv-my-ruby-version]',
    :notify  => 'Exec[rbenv:rehash]'
  ) end
end
