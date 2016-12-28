module Favorito
  # Encapsulate the attributes of a platform in one class
  # and related functionalities in future can be enclosed in
  # this class
  class Platform
    # @!attribute name
    #   @return [String] the name of the platform
    # @!attribute username
    #   @return [String] the username of the platform
    # @!attribute options
    #   @return [Hash] the options of the platform
    attr_accessor :name, :username, :options

    # Create a platform object
    def initialize(name, username, opts = {})
      @name = name
      @username = username
      @options = { query: opts }
    end
  end
end
