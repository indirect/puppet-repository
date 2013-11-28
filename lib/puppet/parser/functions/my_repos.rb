require 'octokit'

module Puppet::Parser::Functions
  newfunction(:my_repos, :type => :rvalue) do |args|
    username, exclusions = lookupvar('github_login'), args
    client = Octokit::Client.new :access_token => lookupvar('github_token')
    client.auto_paginate = true

    # Get every repo that the current user is an owner on
    repos = client.repositories(nil, :owner => true)
    # Remove all the repos that are forks, or belong to another user
    repos.reject!{|r| r.fork || r.owner.login != username }
    # Return full repo names, minus excluded repos
    repos.map{|r| r.full_name } - exclusions.map{|e| "#{username}/#{e}" }
  end
end
