require 'rails_helper'

describe Github::UserRepository do
  context 'passing a username that is invalid' do
    it 'raises invalid user name exception' do
      expect { Github::UserRepository.new('beck--03076') }
        .to raise_error Github::InvalidUsername
    end

    it 'raises empty user name exception' do
      expect { Github::UserRepository.new('') }
        .to raise_error Github::InvalidUsername
    end
  end

  context 'passing a valid username' do
    before do
      @repo = Github::UserRepository.new('beck03076')
    end

    it 'creates a valid user_repository object' do
      expect(@repo).to be_kind_of(Github::UserRepository)
    end

    it 'sets the right username, user path, repos path and url' do
      expect(@repo.username).to eq('beck03076')
      expect(@repo.public_users_path).to eq('users/beck03076')
      expect(@repo.public_user_repos_path).to eq('users/beck03076/repos')
      expect(@repo.url).to eq('https://api.github.com/users/beck03076/repos')
    end
  end
end
