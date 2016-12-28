module Github
  # Class to manage a github user repository with username
  # and encapsulates repository related functionalities
  # eg: username validation
  class UserRepository
    attr_accessor :username

    # Standard Github username format in REGEXP
    USERNAME_PATTERN = /^[a-zA-Z0-9_\.]*$/
    # Invalid user exception message
    INVALID_USER = 'Invalid Github Username.
                    Please enter a valid username!'.freeze

    # create a user_repository
    #
    # @param username [String]
    # @return [UserRepository] if valid username
    # @raise [InvalidUsername] if invalid username
    def initialize(username)
      @username = username
      validate_username!
    end

    # @return [String] github users path
    def public_users_path
      "users/#{@username}"
    end

    # @return [String] git user_repos path
    def public_user_repos_path
      "users/#{@username}/repos"
    end

    # @return [String]
    def url
      "#{Github.api_endpoint}/#{public_user_repos_path}"
    end

    private

    def validate_username!
      raise_invalid! if (@username !~ USERNAME_PATTERN) || @username.blank?
    end

    def raise_invalid!
      raise Github::InvalidUsername, INVALID_USER
    end
  end
end
