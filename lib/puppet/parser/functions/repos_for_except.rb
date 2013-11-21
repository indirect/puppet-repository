module Puppet::Parser::Functions
  newfunction(:repos_for_except, :type => :rvalue) do |args|
    username, *exclusions = *args
    Puppet::Parser::Functions.function('repos_for')
    function_repos_for([username]) - exclusions.map{|e| "#{username}/#{e}" }
  end
end
