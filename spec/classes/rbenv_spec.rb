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

  context "when $ruby" do
    context "when is string" do
      let(:params) { { :ruby => 'my-ruby' } }
      it { should contain_resource("Rbenv::Ruby[my-ruby]") }

      it { should contain_class("rbenv::global").with(
        :version => 'my-ruby'
      ) }
    end

    context "when is array" do
      let(:params) { { :ruby => %w{ ruby1 ruby2} } }
      it { should contain_resource("Rbenv::Ruby[ruby1]") }
      it { should contain_resource("Rbenv::Ruby[ruby2]") }

      it { should contain_class("rbenv::global").with(
        :version => 'ruby1'
      ) }
    end
  end

  context "when $global_version" do
    let(:params){ {
      :global_version => 'my-global-version',
      :ruby           => %w{ my-global-version }
    } }
    it do should contain_class("rbenv::global").with(
      :version => 'my-global-version'
    ) end
  end
end
