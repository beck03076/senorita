module Favorito
  # This is a Null object class which helps for the attributes of
  # the objects to this class to always respond with a default value
  #
  # Null Object Pattern
  # @see https://en.wikipedia.org/wiki/Null_Object_pattern
  class NoPlatform
    NAME = 'Github'.freeze
    USERNAME = 'dummy03076'.freeze

    # @return [String]
    def name
      NAME
    end

    # @return [String]
    def username
      USERNAME
    end

    # @return [Hash]
    def options
      {}
    end
  end
end
