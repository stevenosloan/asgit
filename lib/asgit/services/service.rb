module Asgit
  module Services
    class Service

      class << self
        def register_as name
          Services.register( self, name )
        end
      end

      def base_url
        raise MissingUrlStructure, "#{self.class} does not implement #{__method__}"
      end

      def base_structure
        raise MissingUrlStructure, "#{self.class} does not implement #{__method__}"
      end

      def commit_uri
        raise MissingUrlStructure, "#{self.class} does not implement #{__method__}"
      end

      def branch_uri
        raise MissingUrlStructure, "#{self.class} does not implement #{__method__}"
      end

      def file_uri
        raise MissingUrlStructure, "#{self.class} does not implement #{__method__}"
      end

      def file_at_commit_uri
        raise MissingUrlStructure, "#{self.class} does not implement #{__method__}"
      end

      class MissingUrlStructure < StandardError
      end

    end
  end
end