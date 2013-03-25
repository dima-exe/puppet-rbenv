require 'spec_helper'

describe "rbenv::global" do
  let(:params) { { :version => '1.0.0'} }

  it do should contain_file("/usr/lib/rbenv/version").with(
    :ensure  => 'present',
    :content => '1.0.0',
    :require => 'Rbenv::Ruby[1.0.0]'
  ) end
end
