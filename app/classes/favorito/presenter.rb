module Favorito
  # This is a decorator class that takes an array of sawyer reponse objects
  # as input and provides various intepretations
  #
  # Decorator Pattern
  # @see https://en.wikipedia.org/wiki/Decorator_pattern
  class Presenter < SimpleDelegator
    # Value to be used in place of nil programming language
    # returned by a Platform
    UNKNOWN_LANG = 'Unknown'.freeze

    # Sort the languages group in descending order
    # by number of respositories it is used in
    #
    # @return [Array]
    def sorted_languages_group
      languages_group.sort_by { |_key, value| -value }
    end

    # Extract the favorite language by number of repositories
    #
    # @return [String] if group is valid
    # @return [NilClass] is group is invalid
    def favorite_language
      group = languages_group
      group.max_by { |_key, value| value }[0] if valid?(group)
    end

    # Create a hash of programming language and no of times its used
    # by summing up the response
    #
    # @return [Hash] a hash of { programming_language: :no_of_times },
    # eg: {"Ruby": 18 }
    def languages_group
      @languages_group ||= languages.each_with_object(Hash.new(0)) do |lang, h|
        lang ||= UNKNOWN_LANG
        h[lang] += 1
        h
      end
    end

    private

    # @return [Boolean]
    def valid?(group)
      group.is_a?(Hash) && !group.empty?
    end

    # @return [Array] array of languages
    def languages
      @languages ||= model.pluck(:language)
    end

    # @return [Object] passed object to presenter
    def model
      __getobj__
    end
  end
end
