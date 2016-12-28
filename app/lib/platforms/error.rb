module Platforms
  # A general platforms exception
  class Error < StandardError; end

  # Raised when a none existent class/module name is accessed
  class NameError < Error; end

  # Raised when a non implemented method is called
  class NotImplemented < Error; end

  # Raised when an abstract class is instantiated
  class CannotInstantiate < Error; end

  # Raised when a non existing class is expected
  class ClassDoesNotExist < Error; end
end
