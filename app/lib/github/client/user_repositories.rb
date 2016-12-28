module Github
  class Client
    # methods to be queried on user_repository objects
    # used by Github::Client
    module UserRepositories
      attr_reader :valid
      # User not on guthub exception message
      NO_USER = 'This username is not on github yet!'.freeze

      # Get a github user object
      #
      # @param repo [UserRepository]
      # @param options [Hash]
      # @return [true] if its a valid existing user on github
      # @raise [UserNotFound] if user does not exist
      def valid_user?(repo, options = {})
        response = get(repo.public_users_path, options)
        if response[:id].present?
          true
        else
          raise Github::UserNotFound, [NO_USER,
                                       '[',
                                       response[:message].to_s,
                                       ']'].join
        end
      end

      # Get a github user public repositories
      #
      # @param repo [UserRepository]
      # @param options [Hash]
      # @return [Array] array of sawyer reponse objects
      # @see https://developer.github.com/v3/repos/#get
      def repositories(repo, options = {})
        paginate repo.public_user_repos_path, options if valid_user?(repo)
      end
    end
  end
end
