require 'rspec-puppet'
require 'rspec/mocks'
require 'mocha/api'

RSpec.configure do |c|
  c.mock_with :mocha
  c.default_facts = {
    :github_login => 'indirect',
    :github_token => '123abc'
  }
end
