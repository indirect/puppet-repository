require 'spec_helper'
require 'octokit'

describe 'repos_for_except' do
  let(:client){ mock('client') }
  let(:repos){ %w(cool stuff).map{|n| mock('repo', :full_name => "bob/#{n}") } }

  before do
    Octokit::Client.expects(:new).with(:access_token => '123abc').returns(client)
    client.expects(:auto_paginate=).with(true)
  end

  context 'removes arguments from the list' do
    let(:username){ "bob" }
    before { client.expects(:repositories).with(username).returns(repos) }
    it { should run.with_params(username).and_return(%w(bob/cool bob/stuff)) }
    it { should run.with_params(username, "cool").and_return(%w(bob/stuff)) }
  end
end
