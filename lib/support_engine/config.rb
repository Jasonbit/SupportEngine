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

    config_accessor :current_user_method

    def user_class_name=(value)
      @user_class_name = value
    end

    def user_class_name
      @user_class_name
    end

    def user_class
      @user_class_name.constantize
    end

    def email_address=(value)
      @email_address = value
    end

    def email_address
      @email_address ||= "no-reply@supportengine.org"
    end

    def email_prefix
      @email_prefix ||= "SupportEngine"
    end

    def email_prefix=(value)
      @email_prefix = value
    end
  end
end
