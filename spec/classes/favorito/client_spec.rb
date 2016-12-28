require 'rails_helper'

describe Favorito::Client do
  describe '.new' do
    context 'variations of platform' do
      it 'clients platform is not accessible' do
        expect(@client).to_not respond_to(:platform)
      end

      it 'raises exception for a non existent platform' do
        platform = Favorito::Platform.new(:formplat, 'user')
        client = Favorito::Client.new(platform)

        expect { client.valid_user? }
          .to raise_error Platforms::ClassDoesNotExist
      end
    end

    context 'creating client without platform' do
      it 'passing no platform, instantiates null object' do
        expect { Favorito::Client.new }
          .to_not raise_error
      end

      it 'client without platform returns false for valid_user?' do
        client = Favorito::Client.new

        VCR.use_cassette('no_platform_dummy_cassettes') do
          expect { client.valid_user? }
            .to raise_error Github::UserNotFound
          expect { client.repositories }
            .to raise_error Github::UserNotFound
        end
      end
    end

    context 'creating client with correct platform' do
      let(:platform) { build(:platform1, options: {}) }

      before do
        @client = Favorito::Client.new(platform)
      end

      it 'returns true for valid user' do
        VCR.use_cassette('favorito_client_cassettes') do
          expect(@client.valid_user?).to be_truthy
        end
      end

      it 'returns sawyer response for successful request' do
        VCR.use_cassette('favorito_client_page_cassettes') do
          repos = @client.repositories
          expect(repos).to be_kind_of(Array)
          expect(repos.first).to be_kind_of(Sawyer::Resource)
        end
      end
    end
  end
end
