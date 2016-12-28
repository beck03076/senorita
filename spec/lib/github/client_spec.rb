require 'rails_helper'

describe Github::Client do
  before do
    Github.setup
  end

  describe '.new' do
    before do
      @client = Github::Client.new
    end

    it 'creates an Github::Client' do
      expect(@client).to be_kind_of Github::Client
    end

    it 'assigns the default values' do
      expect(@client.api_endpoint).to eq('https://api.github.com')
      expect(@client.connection_options).to eq(headers: conn_opts)
      expect(@client.per_page).to eq(10)
      expect(@client.web_endpoint).to eq('https://github.com')
      expect(@client.api_endpoint).to eq('https://api.github.com')
      expect(@client.default_media_type).to eq('application/vnd.github.v3+json')
      expect(@client.content_type).to eq('application/json')
      expect(@client.user_agent).to eq('Favorito App')
    end

    describe 'with class level configuration' do
      before do
        @opts = {
          connection_options:  { query: { content_type: 'xml' } },
          per_page: 40,
          content_type: 'xml'
        }
      end

      it 'overrides configuration values' do
        client = Github::Client.new(@opts)
        expect(client.per_page).to eq(40)
        expect(client.content_type).to eq('xml')
        expect(client.connection_options).to eq(query: { content_type: 'xml' })
      end
    end
  end

  describe 'check content type' do
    it 'sets a default Content-Type in the header' do
      req = stub_get('/check')
            .with(headers: { 'Content-Type' => 'application/json' })

      Github.client.get '/check', {}
      assert_requested req
    end
  end

  describe '.agent' do
    before do
      Github.setup
      @agent = Github.client.agent
    end
    it 'is a sawyer agent' do
      expect(Github.client.agent).to be_kind_of(Sawyer::Agent)
    end
    it 'agent is cached' do
      expect(@agent.object_id).to eq(Github.client.agent.object_id)
    end
  end

  describe '.get' do
    before(:each) do
      Github.setup
    end

    it 'handles query params' do
      stub_request(:get, "#{Github.api_endpoint}/check?foo=bar")
        .with(headers: header_opts)
      Github.get '/check', query: { foo: 'bar' }
      assert_requested :get, "#{Github.api_endpoint}/check?foo=bar"
    end

    it 'handles headers' do
      header = header_opts
      header['Accept'] = 'text/plain'
      stub_request(:get, "#{Github.api_endpoint}/check?foo=bar")
        .with(headers: header)
      Github.get('/check',
                 query: { foo: 'bar' },
                 headers: { accept: 'text/plain' })
      assert_requested :get, "#{Github.api_endpoint}/check?foo=bar"
    end
  end

  describe '.paginate' do
    before do
      Github.setup
      @client = Github::Client.new(per_page: 3)
    end

    it 'fetches all the pages' do
      VCR.use_cassette('vcr_cassettes') do
        url = 'users/beck03076/repos'
        @client.paginate url
        assert_requested :get, "#{Github.api_endpoint}/#{url}?per_page=3"
        (2..6).each do |i|
          user_url = "user/4824665/repos?page=#{i}&per_page=3"
          assert_requested :get, "#{Github.api_endpoint}/#{user_url}"
        end
      end
    end
  end
end
