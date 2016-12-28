module Github
  # A general Github exception
  class Error < StandardError; end

  # Raised when behavior is not implemented, usually used in an abstract class.
  class NotImplemented < Error; end

  # Raised when an object is not found.
  class NotFound < Error; end

  # Raised when removed code is called, an alternative solution
  # is provided in message.
  class ImplementationRemoved < Error; end

  # This error is raised when a invalid username
  # for a github repository is passed
  class InvalidUsername < Error; end

  # This error is raised when a repository doesnt exist
  class InvalidRepository < Error; end

  # This error is raised when a user was not found on github
  class UserNotFound < Error; end

  # This error is raised when a user was not found on github
  class InvalidResponse < Error; end
end
