module Asgit
  module Services

    class << self

      def registered
        @_registered ||= {}
      end

      def register service, key
        registered[key] = service
      end

      def fetch service
        registered.fetch(service) do
          raise UndefinedService, "undefined service #{service}"
        end
      end

    end

    class UndefinedService < StandardError
    end

  end
end

require_relative 'services/service'
require_relative 'services/github'
require_relative 'services/bitbucket'
