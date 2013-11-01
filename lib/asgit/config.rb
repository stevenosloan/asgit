module Asgit
  class Config

    attr_reader   :service
    attr_writer   :default_branch
    attr_accessor :organization, :project

    def service= name
      @service = Asgit::Services.send(name.to_sym)
    end

    def default_branch
      @default_branch || 'master'
    end

    def required_attributes
      [ :service, :organization, :project ]
    end

  end

  class << self
    def configure &block
      yield config
    end

    def config
      @_config ||= Config.new
    end

    def configured?
      config.required_attributes.each do |attr|
        return false unless config.send(attr)
      end

      true
    end
  end
end