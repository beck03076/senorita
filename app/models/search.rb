# Search as a tableless rails model
# initialized with the attributes to be used for search
# and render the search form
#
# Rails Tableless Model
#
# @see http://railscasts.com/episodes/193-tableless-model
class Search
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :username, :result

  def initialize
    yield(self) if block_given?
  end

  class << self
    # Class method that instantiates a search object with input username
    # also sets the result with fetched repositories
    #
    # @return [Search] object with username, result
    def perform(params)
      new do |search|
        search.username = params[:username]
        search.result = search.fetch_repositories
      end
    end
  end

  # Delegate the fetching of repositories to the favorito client
  # in order to avoid mock trainwrecks
  #
  # Law of Demeter
  # @see https://en.wikipedia.org/wiki/Law_of_Demeter
  def fetch_repositories
    client.repositories
  end

  # To be a tableless model
  def persisted?
    false
  end

  private

  # @return [Favorito::Client]
  def client
    @client ||= Favorito::Client.new(platform)
  end

  # @return [Favorito::Platform]
  def platform
    @platform ||= Favorito::Platform.new(:github, @username)
  end
end
