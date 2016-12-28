##
#
# Github
# @author Senthil Kumar Muthamizhan
#
# Creates connection to Github API with default configuration
# and uses a client to communicate with the API
#
# @see Github::Connection
# @see Github::Configuration
# @see Github::Client
# @see Github::Default
#
module Github
  class << self
    include Github::Configuration

    # Client with default configuration options set
    #
    # @return [Github::Client]
    def client
      return @client if defined?(@client)
      @client = Github::Client.new(options)
    end

    private

    # respond to returning the method object
    # @param method_name [Symbol]
    # @param include_private [Boolean]
    # @return [Boolean]
    def respond_to_missing?(method_name, include_private = false)
      client.respond_to?(method_name, include_private)
    end

    # Hand method and argument on to instance if it responds to method,
    # otherwise calls super
    # @param method_name [Symbol]
    # @param args [Array<Symbol>] arguments
    # @return [true, false]
    def method_missing(method_name, *args, &block)
      if client.respond_to?(method_name)
        return client.send(method_name, *args, &block)
      else
        super
      end
    end
  end
end

Github::Error
