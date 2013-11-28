require 'spec_helper'
require 'octokit'

describe 'repos_for' do
  let(:username){ "bob" }
  let(:client){ mock('client') }
  let(:repos) do
    %w(cool stuff).map { |n| mock('repo', :full_name => "#{username}/#{n}") }
  end

  before do
    Octokit::Client.expects(:new).with(:access_token => '123abc').returns(client)
    client.expects(:auto_paginate=).with(true)
    client.expects(:repositories).with(username).returns(repos)
  end

  it "returns repos for the given user" do
    should run.with_params(username).and_return(%w(bob/cool bob/stuff))
  end

  it "excludes repos given in additional arguments" do
    should run.with_params(username, "cool").and_return(%w(bob/stuff))
  end
end
