module Github
  # Default configuration options for Github::Client
  module Default
    # Default API endpoint
    API_ENDPOINT = 'https://api.github.com'.freeze
    # Default WEB endpoint
    WEB_ENDPOINT = 'https://github.com'.freeze
    # Default media type
    MEDIA_TYPE   = 'application/vnd.github.v3+json'.freeze
    # Default content type
    CONTENT_TYPE = 'application/json'.freeze
    # Default user agent
    USER_AGENT = 'Favorito App'.freeze
    # Default per page
    PER_PAGE = 10

    class << self
      # Configuration options
      # @return [Hash]
      def options
        Hash[Github::Configuration.keys.map { |key| [key, send(key)] }]
      end

      # @return [String]
      def api_endpoint
        API_ENDPOINT
      end

      # Default options for Faraday::Connection
      # @return [Hash]
      def connection_options
        {
          headers: {
            accept: default_media_type,
            user_agent: user_agent,
            content_type: content_type
          }
        }
      end

      # @return [String]
      def default_media_type
        MEDIA_TYPE
      end

      # @return [String]
      def user_agent
        USER_AGENT
      end

      # @return [String]
      def content_type
        CONTENT_TYPE
      end

      # @return [Fixnum]
      def per_page
        PER_PAGE
      end

      # @return [String]
      def web_endpoint
        WEB_ENDPOINT
      end
    end
  end
end
