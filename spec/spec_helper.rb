require 'simplecov'
require 'webmock/rspec'
require 'vcr'
require 'factory_girl_rails'

SimpleCov.start 'rails'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  # config.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end

def stub_get(url)
  stub_request(:get, "#{Github.api_endpoint}#{url}")
end

def header_opts
  { 'Accept' => 'application/vnd.github.v3+json',
    'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    'Content-Type' => 'application/json',
    'User-Agent' => 'Favorito App' }
end

def conn_opts
  { accept: 'application/vnd.github.v3+json',
    user_agent: 'Favorito App',
    content_type: 'application/json' }
end
