require 'rails_helper'

describe Platforms::AbstractClient do
  describe '.new' do
    it 'raises an exception Platforms::CannotInstantiate' do
      expect { Platforms::AbstractClient.new }
        .to raise_error Platforms::CannotInstantiate
    end
  end

  context 'interiting subclasses without method implementations' do
    before do
      class TestClass < Platforms::AbstractClient; def initialize; end end
      @obj = TestClass.new
    end

    it 'raise NotImplement error' do
      expect { @obj.valid_user? }
        .to raise_error Platforms::NotImplemented
    end

    it 'raise NotImplement error' do
      expect { @obj.repositories }
        .to raise_error Platforms::NotImplemented
    end
  end

  context 'interiting subclasses with method implementations' do
    before do
      class TestClass < Platforms::AbstractClient
        def initialize; end

        def valid_user?; end

        def repositories; end
      end
      @obj = TestClass.new
    end

    it 'raise NotImplement error' do
      expect { @obj.valid_user? }
        .not_to raise_error
    end

    it 'raise NotImplement error' do
      expect { @obj.repositories }
        .not_to raise_error
    end
  end
end
