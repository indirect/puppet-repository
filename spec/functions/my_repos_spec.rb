require 'spec_helper'
require 'octokit'

describe 'my_repos' do
  let(:facts){ {'github_login' => 'bob' } }
  let(:bob){ stub('owner', :login => 'bob') }
  let(:client){ mock('client') }
  let(:repos) {[
    stub('repo', :fork => false, :owner => bob, :full_name => "bob/cool"),
    stub('repo', :fork => false, :owner => bob, :full_name => "bob/stuff")
  ]}

  before do
    Octokit::Client.expects(:new).with(:access_token => '123abc').returns(client)
    client.expects(:auto_paginate=).with(true)
    client.expects(:repositories).with(nil, :owner => true).returns(repos)
  end

  it "returns repos owned by the github user" do
    should run.with_params([]).and_return(%w(bob/cool bob/stuff))
  end

  it "does not return repos that are forks" do
    repos << mock('repo', :fork => true)
    should run.with_params([]).and_return(%w(bob/cool bob/stuff))
  end

  it "does not return repos owned by other github users" do
    octocat = stub('owner', :login => 'octocat')
    repos << stub('repo', :fork => false, :owner => octocat)
    should run.with_params([]).and_return(%w(bob/cool bob/stuff))
  end

  it "does not return repos given in parameters" do
    should run.with_params("cool").and_return(%w(bob/stuff))
  end
end
