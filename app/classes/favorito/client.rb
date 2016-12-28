##
#
# Favorito
# @author Senthil Kumar Muthamizhan
#
# Namespace for the classes that will be used directly
# by the app
#
#
module Favorito
  # This client must implement the abstract_methods and
  # it is reponsible for instantiating the right/appropriate
  # platform's client(eg: Github, Bitbucket) using the platform object
  # passed to it
  class Client < Platforms::AbstractClient
    # Initialize a favorito client
    #
    # @param _platform [Favorito::Platform]
    # @see Favorito::Platform
    def initialize(new_platform = nil)
      @platform = new_platform
      @options =  platform.options
    end

    # Check if the username is valid and existing on platform
    #
    # @return [Boolean]
    def valid_user?
      client.valid_user?(user_repo, @options)
    end

    # Fetch all the public repositories on platform for this user
    #
    # @return [Array] array of sawyer response objects
    def repositories
      client.repositories(user_repo, @options)
    end

    private

    # Set the platform instance variable for a new client
    # with a Noplatform instance(Null object class) if it does not exist
    # else uses the assigned platform
    #
    # @overload platform
    #   Sets the platform
    #   @param [NoPlatform.new] the new platform if its nil
    def platform
      @platform ||= NoPlatform.new
    end

    # Set the client instance variable for a new client
    # with correct platform client object based on the
    # values of the passed platform
    #
    # @overload client
    #   Sets the client
    #   @param [platform::Client] the new platform client
    def client
      @client ||= platform_klass::Client.new(@options)
    end

    # Set the user_repo for a new client
    # with correct platform user_repository object based on name of the platform
    #
    # @overload user_repo
    #   Sets the user_repo
    #   @param [platform::UserRepository] the new platform user_repo
    def user_repo
      @user_repo ||= platform_klass::UserRepository.new(@platform.username)
    end

    # Return the existing platform class and resolving a class name from
    # the platform object's name attribute
    #
    # @return [platform] eg: Github
    # @raise [ClassDoesNotExist] if it does not exists
    def platform_klass
      @platform.name.to_s.classify.constantize

    rescue NameError
      raise Platforms::ClassDoesNotExist
    end
  end
end
