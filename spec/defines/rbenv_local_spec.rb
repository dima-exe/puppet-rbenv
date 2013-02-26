require 'spec_helper'

describe "rbenv::local" do
  let(:title) { '/my/app/dir' }
  let(:params){ { :owner => "my-user", :version => 'my-version' } }

  it do should contain_file("/my/app/dir/.ruby-version").with(
    :content => 'my-version',
    :owner   => 'my-user',
    :require => 'Rbenv::Ruby[my-version]'
  ) end
end
