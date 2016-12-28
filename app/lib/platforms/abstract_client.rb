##
#
# Platforms
# @author Senthil Kumar Muthamizhan
#
# container for all the platform classes to be inherited from
# the abstract client base class
#
# @see https://en.wikipedia.org/wiki/Abstract_factory_pattern
#

module Platforms
  # This is an abstract class, cannot be instantiated
  # It enforces it's child classes to implement methods
  # that are listed as abstract_methods
  class AbstractClient
    # This method is made avilable by override module class
    # @see lib/core_ext/module.rb
    abstract_methods :repositories, :valid_user?

    # @raise [CannotInstantiate] if you try to create an object
    def initialize(_opts = nil)
      raise Platforms::CannotInstantiate
    end
  end
end

Platforms::Error
