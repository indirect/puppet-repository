require 'octokit'

module Puppet::Parser::Functions
  newfunction(:repos_for, :type => :rvalue) do |args|
    client = Octokit::Client.new :access_token => lookupvar('github_token')
    client.auto_paginate = true
    my_repos = args.first == lookupvar('github_login')
    if my_repos
      client.repositories(nil, :type => "owner").map{|r| r.full_name }
    else
      client.repositories(args.first).map{|r| r.full_name }
    end
  end
end
