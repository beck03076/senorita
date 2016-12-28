# Extend the code module class to define an abstract_methods method
# to implement abstract factory pattern
#
# @see Platforms::AbstractClient
class Module
  # Define methods that are passed as args
  #
  # @raise [NotImplemented] if the subclasses do not implement it
  def abstract_methods(*names)
    names.each do |name|
      define_method(name) { raise Platforms::NotImplemented }
    end
  end
end
