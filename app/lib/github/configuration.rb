module Github
  # Configuration options for client
  # define an array of keys that hold the config options
  module Configuration
    attr_accessor :per_page, :api_endpoint, :web_endpoint,
                  :connection_options, :default_media_type,
                  :user_agent, :content_type

    class << self
      # Configuration keys for Github::Client
      # more keys can be added later like client_id and client_token
      #
      # @return [Array]
      def keys
        @keys ||= [
          :api_endpoint,
          :connection_options,
          :per_page,
          :web_endpoint,
          :default_media_type,
          :content_type,
          :user_agent
        ]
      end
    end

    # Reset configuration options to default values
    #
    # @return [self]
    def setup
      Github::Configuration.keys.each do |key|
        instance_variable_set(:"@#{key}", Github::Default.options[key])
      end
      self
    end

    private

    # Return key: value pair of options set from Default
    #
    # @return [Hash]
    def options
      Hash[Github::Configuration.keys.map do |key|
        [key, instance_variable_get(:"@#{key}")]
      end]
    end
  end
end
