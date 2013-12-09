module Asgit
  class Project

    def initialize project_details={}
      project_details.each do |k,v|
        details.public_send( :"#{k}=", v )
      end
    end

    def details
      @_details ||= Details.new
    end

    class Details
      attr_accessor :service, :organization, :project, :default_branch
    end

  end
end