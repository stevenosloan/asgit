module Asgit
  class Project

    Details = Struct.new :service, :organization, :project, :default_branch, :base_url

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
      @_service ||= Services.fetch( details.service ).new( details )
    end

    def urls
      @_urls ||= Url.new details, service
    end

  end
end