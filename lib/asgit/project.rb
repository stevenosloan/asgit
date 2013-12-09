module Asgit
  class Project

    def initialize project_details={}
      project_details.each do |k,v|
        begin
          details.public_send( :"#{k}=", v )
        rescue NoMethodError => e
          raise ArgumentError, "unknown keyword: #{e.name.to_s.chomp('=')}"
        end
      end
    end

    def details
      @_details ||= Details.new
    end

    def service
      @_service ||= Services.public_send details.service
    end

    def urls
      @_urls ||= Url.new details, service
    end

    class Details
      attr_accessor :service, :organization, :project, :default_branch
    end

  end
end