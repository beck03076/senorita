require 'rails_helper'

describe Github do
  before do
    Github.setup
  end

  it 'sets defaults' do
    Github::Configuration.keys.each do |key|
      expect(Github.instance_variable_get(:"@#{key}"))
        .to eq(Github::Default.send(key))
    end
  end

  describe '.client' do
    it 'creates an Github::Client' do
      expect(Github.client).to be_kind_of Github::Client
    end
    it 'responds to keys' do
      expect(Github.api_endpoint).to eq('https://api.github.com')
      expect(Github.connection_options).to eq(headers: conn_opts)
      expect(Github.per_page).to eq(10)
      expect(Github.web_endpoint).to eq('https://github.com')
      expect(Github.api_endpoint).to eq('https://api.github.com')
      expect(Github.default_media_type).to eq('application/vnd.github.v3+json')
      expect(Github.content_type).to eq('application/json')
      expect(Github.user_agent).to eq('Favorito App')
    end
  end
end
