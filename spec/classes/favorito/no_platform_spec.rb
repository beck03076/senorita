require 'rails_helper'

describe Favorito::NoPlatform do
  describe '.new' do
    it 'assigns default valuse' do
      platform = Favorito::NoPlatform.new

      expect(platform.name).to eq('Github')
      expect(platform.username).to eq('dummy03076')
      expect(platform.options).to eq({})
    end
  end
end
