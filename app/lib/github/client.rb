module Github
  # Client for the GitHub API
  #
  # @see https://developer.github.com
  class Client < Platforms::AbstractClient
    include Github::Configuration
    include Github::Connection
    include Github::Client::UserRepositories

    # Creates the client object to communicate with the API
    # Sets the configuration keys with values from defaul

    # @see Github::Default
    def initialize(options = {})
      # Use options passed in, but fall back to module defaults
      Github::Configuration.keys.each do |key|
        value = options[key] || Github.instance_variable_get(:"@#{key}")
        instance_variable_set(:"@#{key}", value)
      end
    end
  end
end
