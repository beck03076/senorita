require 'rails_helper'

describe Search do
  describe '.persisted?' do
    it 'returns false for tableless model' do
      expect(Search.new.persisted?).to be_falsy
    end
  end

  describe '.new' do
    it 'attributes are accessible' do
      search = Search.new
      expect(search).to respond_to(:username)
      expect(search).to respond_to(:result)
    end

    it 'initializes attributes if given in blocks' do
      search = Search.new do |s|
        s.username = 'Donald Trump'
        s.result = 'I win!'
      end
      expect(search.username).to eq('Donald Trump')
      expect(search.result).to eq('I win!')
    end
  end

  describe '.fetch_repositories' do
    it 'raises error' do
      VCR.use_cassette('favorito_client_page_nonil_cassettes') do
        search = Search.new
        expect { search.fetch_repositories }
          .to raise_error Github::InvalidUsername
      end
    end
  end

  describe '.perform' do
    it 'return result with repositories and user name' do
      VCR.use_cassette('favorito_client_page_nonil_cassettes') do
        search = Search.perform(username: 'beck03076')
        expect(search.username).to eq('beck03076')
        expect(search.result).to be_kind_of(Array)
        expect(search.result.first).to be_kind_of(Sawyer::Resource)
      end
    end
  end
end
