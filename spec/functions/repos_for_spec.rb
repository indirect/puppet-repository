require 'spec_helper'
require 'octokit'

describe 'repos_for' do
  let(:client){ mock('client') }
  let(:repos){ %w(cool stuff).map{|n| mock('repo', :full_name => n) } }

  before do
    Octokit::Client.expects(:new).with(:access_token => '123abc').returns(client)
    client.expects(:auto_paginate=).with(true)
  end

  context 'called with the current github username' do
    before { client.expects(:repositories).with(nil, :type => "owner").returns(repos) }
    it { should run.with_params('indirect').and_return(%w(cool stuff)) }
  end

  context 'called with any other username' do
    let(:username){ "bob" }
    before { client.expects(:repositories).with(username).returns(repos) }
    it { should run.with_params(username).and_return(%w(cool stuff)) }
  end
end
