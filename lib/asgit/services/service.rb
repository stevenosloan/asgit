module Asgit
  module Services
    class Service

      class << self
        def register_as name
          Services.register( self, name )
        end
      end

      [ :base_url, :base_structure,
        :commit_uri, :branch_uri, :file_uri,
        :file_at_commit_uri, :compare_uri
      ].each do |m|
        define_method m do
          raise MissingUrlStructure, "#{self.class} does not implement #{__method__}"
        end
      end

      class MissingUrlStructure < StandardError
      end

    end
  end
end