require 'spec_helper'

describe 'rbenv' do
  it { should contain_package("rbenv") }
  it { should contain_package("build-essential") }

  it do should contain_exec("rbenv:rehash").with(
    :command     => "/usr/bin/rbenv rehash || true",
    :environment => "RBENV_ROOT=/usr/lib/rbenv",
    :refreshonly => true
  ) end

  it do should contain_file("/etc/gemrc").with(
    :content => "gem: --no-ri --no-rdoc
"
  ) end

  context "when $global_version is set" do
    let(:params){ { global_version: 'my-global-version' } }
    it do should contain_file("/usr/lib/rbenv/version").with(
      :content => 'my-global-version',
      :require => 'Rbenv::Ruby[my-global-version]'
    ) end
  end
end
