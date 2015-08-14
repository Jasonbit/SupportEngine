require 'active_support/configurable'

module SupportEngine
  def self.configure(&block)
    yield config
  end

  def self.config
    @config ||= SupportEngine::Configuration.new
  end

  class Configuration
    include ActiveSupport::Configurable

    config_accessor :user_class_name, :current_user_method

    def user_class
      config.user_class_name.constantize
    end
  end
end
