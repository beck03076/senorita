require 'rails_helper'

describe Github::Client::UserRepositories do
  context 'non existing user on github' do
    before do
      Github.setup
      @client = Github::Client.new
      @user_repo = Github::UserRepository.new('beck.non.existing')
    end

    it 'raises exception for a non existing user' do
      VCR.use_cassette('no_user_repository_cassettes') do
        expect { @client.valid_user?(@user_repo) }
          .to raise_error Github::UserNotFound
      end
    end

    it 'raises exception for a non existing user' do
      VCR.use_cassette('no_user_repository_cassettes') do
        expect { @client.repositories(@user_repo) }
          .to raise_error Github::UserNotFound
      end
    end
  end

  context 'existing user on github' do
    before do
      Github.setup
      @client = Github::Client.new
      @user_repo = Github::UserRepository.new('beck03076')
    end

    it 'returns true for an existing user' do
      VCR.use_cassette('user_repository_cassettes') do
        expect(@client.valid_user?(@user_repo)).to be_truthy
      end
    end

    it 'returns an array of repos from github for this user' do
      VCR.use_cassette('user_repository_details_cassettes') do
        repos = @client.repositories(@user_repo)
        expect(repos).to be_a(Array)
      end
    end

    it 'returns an array of repos from github with right attributes' do
      VCR.use_cassette('user_repository_details_cassettes') do
        repos = @client.repositories(@user_repo)
        repo = repos.first.to_hash
        expect(repo).to include(:id,
                                :name,
                                :full_name,
                                :owner,
                                :private,
                                :html_url,
                                :description,
                                :language)
      end
    end
  end
end
