require 'octokit'

module Puppet::Parser::Functions
  newfunction(:repos_for, :type => :rvalue) do |args|
    username, *exclusions = *args
    exclusions.map!{|e| "#{username}/#{e}" }

    client = Octokit::Client.new :access_token => lookupvar('github_token')
    client.auto_paginate = true

    repo_names = client.repositories(args[0]).map{|r| r.full_name }
    repo_names - exclusions
  end
end
