module Github
  # Network layer for API clients.
  module Connection
    # Make a HTTP GET request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    #
    # @return Faraday Response
    def get(url, options = {})
      request :get, url, {}, prepare_options(options)
    end

    # Make a HTTP POST request
    #
    # @return Faraday Response
    def post(url, options = {})
      request :post, url, options
    end

    # Make a HTTP PUT request
    #
    # @return Faraday Response
    def put(url, options = {})
      request :put, url, options
    end

    # Make a HTTP DELETE request
    #
    # @return Faraday Response
    def delete(url, options = {})
      request :delete, url, options
    end

    # Make multiple HTTP GET requests, based on the per_page
    # parameter value
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def paginate(url, options = {})
      opts = prepare_options(options)
      opts[:query][:per_page] ||= @per_page if @per_page
      iterate_response(url, opts)
    end

    # Makes multiple requests based on the value of rel=next
    #
    # @return [Array]
    def iterate_response(url, opts)
      data = request(:get, url, {}, opts)
      while @prev_response.rels[:next]
        Rails.logger.info '.'
        @prev_response = @prev_response.rels[:next].get
        data.concat(@prev_response.data) if @prev_response.data.is_a?(Array)
      end
      data
    end

    # Take options and insert query and headers keys
    #
    # @return [Hash]
    def prepare_options(options)
      opts = {}
      opts[:query] = options.fetch(:query, {})
      opts[:headers] = options.fetch(:headers, {})
      opts
    end

    # Hypermedia agent for the GitHub API
    #
    # @return [Sawyer::Agent]
    def agent
      @agent ||= Sawyer::Agent.new(endpoint, sawyer_options)
    end

    # Response for previous HTTP request
    #
    # @return [Sawyer::Response]
    def prev_response
      @prev_response if defined? @prev_response
    end

    protected

    # @return [api_endpoint]
    def endpoint
      api_endpoint
    end

    private

    def reset_agent
      @agent = nil
    end

    # make the actual HTTP request by calling a method
    # on the sawyer agent, eg: :get
    #
    # @return [Array] array of sawyer response objects
    def request(method, path, data, options = {})
      @prev_response = response = agent.call(method,
                                             URI::Parser.new.escape(path.to_s),
                                             data,
                                             options)
      response.data
    end

    def sawyer_options
      opts = {
        links_parser: Sawyer::LinkParsers::Simple.new
      }
      conn_opts = @connection_options
      opts[:faraday] = Faraday.new(conn_opts)
      opts
    end
  end
end
