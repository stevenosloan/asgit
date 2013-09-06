module Asgit
  class Config
    attr_accessor :organization, :project

    def service
      @_service
    end

    def service= name
      @_service = Asgit::Services.send(name.to_sym)
    end

  end

  class << self
    def configure &block
      yield config
    end

    def config
      @_config ||= Config.new
    end
  end
end