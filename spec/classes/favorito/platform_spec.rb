require 'rails_helper'

describe Favorito::Platform do
  describe '.new' do
    let(:platform) { build(:platform1) }

    it 'creates a platform object in the right format' do
      expect(platform.name).to eq(:github)
      expect(platform.username).to eq('beck03076')
      expect(platform.options).to eq(query: { per_page: 10 })
    end
  end
end
