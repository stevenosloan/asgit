require 'here_or_there'

module Asgit
  module Shell
    class << self

      def run command
        HereOrThere::Local.new.run command
      end

    end
  end
end
